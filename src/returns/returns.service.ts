import {
  ConflictException,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { randomBytes } from 'node:crypto';
import { DateTime } from 'luxon';
import type {
  BookReturnRequest,
  ReturnShipmentView,
  Uuid,
  ValidateReturnRequest,
  ValidateReturnResponse,
} from '../contracts';
import { AccountsService } from '../accounts/accounts.service';
import { CarriersService } from '../carriers/carriers.service';
import { TrackingService } from '../tracking/tracking.service';
import { signTrackingValue, verifyReturnToken } from '../common/token';
import { FreightPrismaService } from '../prisma/freight-prisma.service';
import {
  type ShipmentRecord,
  ShipmentsService,
} from '../shipments/shipments.service';
import type { Prisma } from '../../models/freight/client';

@Injectable()
export class ReturnsService {
  constructor(
    private readonly freight: FreightPrismaService,
    private readonly shipments: ShipmentsService,
    private readonly tracking: TrackingService,
    private readonly accounts: AccountsService,
    private readonly carriers: CarriersService,
  ) {}

  async findByCode(
    returnCode: string,
    token: string,
  ): Promise<ReturnShipmentView> {
    const shipment = await this.shipments.findReturnByCode(returnCode);
    if (!shipment) throw new NotFoundException('Return shipment not found');
    if (!verifyReturnToken(token, shipment.id as Uuid, returnCode)) {
      throw new UnauthorizedException('Invalid or expired return token');
    }
    return this.toView(shipment);
  }

  async validate(
    input: ValidateReturnRequest,
  ): Promise<ValidateReturnResponse> {
    const shipment = await this.shipments.findReturnByCode(input.returnCode);
    if (!shipment) throw new UnauthorizedException('Invalid return code');
    const validValues = new Set(
      [
        shipment.consignmentReference,
        shipment.internalReference,
        shipment.details?.consignmentReference,
        shipment.details?.internalReference,
        shipment.sender.location.contact?.email,
      ].filter((value): value is string => Boolean(value)),
    );
    if (!validValues.has(input.validationNumber)) {
      throw new UnauthorizedException('Invalid return validation number');
    }
    const expiresInSeconds = 3600;
    const expiresAt = Math.floor(Date.now() / 1000) + expiresInSeconds;
    const nonce = randomBytes(16).toString('hex');
    const payload = `${shipment.id}.${input.returnCode}.${expiresAt}.${nonce}`;
    return {
      returnCode: input.returnCode,
      token: `${payload}.${signTrackingValue(payload)}`,
      expiresInSeconds,
    };
  }

  async book(
    shipmentId: Uuid,
    token: string,
    input: BookReturnRequest,
  ): Promise<ReturnShipmentView> {
    const source = await this.findReturnById(shipmentId);
    if (!source) throw new NotFoundException('Return shipment not found');
    if (
      !source.returnCode ||
      !verifyReturnToken(token, shipmentId, source.returnCode)
    ) {
      throw new UnauthorizedException('Invalid or expired return token');
    }
    if (source.pickupId || source.pickup) {
      throw new ConflictException('Return shipment already has a pickup');
    }
    const pickupReference = this.shipments.createPickupReference();
    const pickupDate = this.toDateTime(
      input.pickup.pickupDate,
      '00:00',
      input.pickup.timezone,
    );
    const readyTime = this.toDateTime(
      input.pickup.pickupDate,
      input.pickup.readyTime,
      input.pickup.timezone,
    );
    const closingTime = this.toDateTime(
      input.pickup.pickupDate,
      input.pickup.closingTime,
      input.pickup.timezone,
    );
    const update = async (tx: Prisma.TransactionClient) => {
      const data = {
        sender: {
          update: {
            name: input.sender.companyName,
            isResidential: input.sender.isResidential ?? false,
            location: {
              update: {
                address: {
                  update: {
                    addressLine1: input.sender.address.addressLine1,
                    addressLine2: input.sender.address.addressLine2,
                    suburb: input.sender.address.suburb,
                    state: input.sender.address.state,
                    postcode: input.sender.address.postcode,
                    country: input.sender.address.countryCode ?? 'AU',
                    countryCode: input.sender.address.countryCode ?? 'AU',
                  },
                },
                contact: {
                  update: {
                    name: input.sender.contact.name,
                    email: input.sender.contact.email,
                    additionalEmails:
                      input.sender.contact.additionalEmails ?? [],
                    phoneNumber: input.sender.contact.phoneNumber,
                  },
                },
              },
            },
          },
        },
        details: { update: { isReturnConfirmed: true } },
        packages: {
          deleteMany: {},
          create: input.packages.map((pkg) => ({
            name: pkg.name,
            reference: pkg.reference,
            packageType: pkg.packageType,
            quantity: pkg.quantity,
            weight: pkg.weight,
            length: pkg.length,
            width: pkg.width,
            height: pkg.height,
            labelQuantity: 1,
            isEnablePrint: true,
            tenantId: source.tenantId,
          })),
        },
        pickup: {
          create: {
            pickupReference,
            pickupDate,
            readyTime,
            closingTime,
            timezone: input.pickup.timezone,
            internalReference: input.pickup.internalReference,
            pickupArea: input.pickup.pickupArea,
            specialInstructions: input.pickup.specialInstructions,
            tenantId: source.tenantId,
            pickupStatus: 'PENDING' as const,
            status: 'PICKUP_PENDING' as const,
            senderName: input.sender.companyName,
            receiverName: source.receiver?.name,
          },
        },
      };
      if ('customerReference' in source) {
        return tx.newShipment.update({
          where: { id: shipmentId },
          data,
          include: {
            sender: {
              include: {
                location: { include: { address: true, contact: true } },
              },
            },
            receiver: {
              include: {
                location: { include: { address: true, contact: true } },
              },
            },
            details: true,
            packages: { include: { packageContents: true } },
            paperwork: true,
            palletsManagement: true,
            pickup: true,
          },
        });
      }
      return tx.shipment.update({
        where: { id: shipmentId },
        data,
        include: {
          sender: {
            include: {
              location: { include: { address: true, contact: true } },
            },
          },
          receiver: {
            include: {
              location: { include: { address: true, contact: true } },
            },
          },
          details: true,
          packages: { include: { packageContents: true } },
          paperwork: true,
          palletsManagement: true,
          pickup: true,
        },
      });
    };
    const shipment = await this.freight.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${source.tenantId}, TRUE)`;
      return update(tx);
    });
    return this.toView(shipment as ShipmentRecord);
  }

  private async findReturnById(id: Uuid): Promise<ShipmentRecord | null> {
    return this.freight.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.bypass_rls', 'on', TRUE)`;
      const current = await tx.newShipment.findFirst({
        where: { id, returnCode: { not: null } },
        include: {
          sender: {
            include: {
              location: { include: { address: true, contact: true } },
            },
          },
          receiver: {
            include: {
              location: { include: { address: true, contact: true } },
            },
          },
          details: true,
          packages: { include: { packageContents: true } },
          paperwork: true,
          palletsManagement: true,
          pickup: true,
        },
      });
      if (current) return current;
      return tx.shipment.findFirst({
        where: { id, returnCode: { not: null } },
        include: {
          sender: {
            include: {
              location: { include: { address: true, contact: true } },
            },
          },
          receiver: {
            include: {
              location: { include: { address: true, contact: true } },
            },
          },
          details: true,
          packages: { include: { packageContents: true } },
          paperwork: true,
          palletsManagement: true,
          pickup: true,
        },
      });
    });
  }

  private toDateTime(date: string, time: string, timezone: string): Date {
    const value = DateTime.fromISO(`${date}T${time}`, { zone: timezone });
    if (!value.isValid) {
      throw new UnauthorizedException(
        `Invalid pickup date, time, or timezone: ${value.invalidExplanation ?? ''}`,
      );
    }
    return value.toUTC().toJSDate();
  }

  private async toView(shipment: ShipmentRecord): Promise<ReturnShipmentView> {
    const response = this.shipments.toResponse(shipment, true);
    const [tracking, account, supplier] = await Promise.all([
      this.tracking.getTrackingEvents(response.tenantId, response.id),
      this.accounts.findOne(response.tenantId, response.accountId),
      this.carriers.findByName(response.carrier),
    ]);
    return {
      shipment: response,
      tracking: tracking.trackingEvents,
      account,
      supplier,
      branding: {
        logo: 'https://storage.googleapis.com/tig-freight-bucket/public/logo/alm%20logo.jpg.jpeg',
        logoLink: 'https://www.allmar.com.au/',
        logoPosition: 'top-right',
        background:
          'https://storage.googleapis.com/tig-freight-bucket/public/background/117334022_2539813489662176_4213495371253910930_o.jpg.jpeg',
        heading: 'Carrier Shipment Tracking',
        theme: 'light',
      },
    };
  }
}
