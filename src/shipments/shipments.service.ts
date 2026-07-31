import { Injectable, NotFoundException } from '@nestjs/common';
import { randomUUID } from 'node:crypto';
import type {
  DateTimeString,
  Email,
  ShipmentListQuery,
  ShipmentListResponse,
  ShipmentResponse,
  Uuid,
} from '../contracts';
import { compact, toDecimalString, toOptional } from '../common/json';
import { currentTrackingWindow, signTrackingValue } from '../common/token';
import { FreightPrismaService } from '../prisma/freight-prisma.service';
import type { Prisma } from '../../models/freight/client';

const legacyShipmentInclude = {
  sender: {
    include: { location: { include: { address: true, contact: true } } },
  },
  receiver: {
    include: { location: { include: { address: true, contact: true } } },
  },
  details: true,
  packages: { include: { packageContents: true } },
  paperwork: true,
  palletsManagement: true,
  pickup: true,
} satisfies Prisma.ShipmentInclude;

const newShipmentInclude = {
  sender: {
    include: { location: { include: { address: true, contact: true } } },
  },
  receiver: {
    include: { location: { include: { address: true, contact: true } } },
  },
  details: true,
  packages: { include: { packageContents: true } },
  paperwork: true,
  palletsManagement: true,
  pickup: true,
} satisfies Prisma.NewShipmentInclude;

type LegacyShipmentRecord = Prisma.ShipmentGetPayload<{
  include: typeof legacyShipmentInclude;
}>;
type NewShipmentRecord = Prisma.NewShipmentGetPayload<{
  include: typeof newShipmentInclude;
}>;
export type ShipmentRecord = LegacyShipmentRecord | NewShipmentRecord;

@Injectable()
export class ShipmentsService {
  constructor(private readonly freight: FreightPrismaService) {}

  async findByReference(reference: string): Promise<ShipmentResponse> {
    const shipment = await this.freight.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.bypass_rls', 'on', TRUE)`;
      const current = await tx.newShipment.findFirst({
        where: {
          OR: [{ reference }, { shipmentReferenceId: reference }],
        },
        include: newShipmentInclude,
      });
      if (current) return current;
      return tx.shipment.findFirst({
        where: {
          OR: [{ reference }, { shipmentReferenceId: reference }],
        },
        include: legacyShipmentInclude,
      });
    });
    if (!shipment) throw new NotFoundException('Shipment not found');
    return this.toResponse(shipment, true);
  }

  async findById(tenantId: Uuid, id: Uuid): Promise<ShipmentResponse> {
    const shipment = await this.findRecordById(tenantId, id);
    if (!shipment) throw new NotFoundException('Shipment not found');
    return this.toResponse(shipment);
  }

  async list(
    tenantId: Uuid,
    query: ShipmentListQuery,
  ): Promise<ShipmentListResponse> {
    const limit = Math.min(Math.max(query.limit ?? 50, 1), 200);
    const offset = Math.max(query.offset ?? 0, 0);
    const where = {
      tenantId,
      ...(query.accountId ? { accountId: query.accountId } : {}),
      ...(query.customerGroupId
        ? { customerGroupId: query.customerGroupId }
        : {}),
      ...(query.status ? { status: query.status as never } : {}),
      ...(query.reference
        ? {
            OR: [
              {
                reference: {
                  contains: query.reference,
                  mode: 'insensitive' as const,
                },
              },
              {
                shipmentReferenceId: {
                  contains: query.reference,
                  mode: 'insensitive' as const,
                },
              },
            ],
          }
        : {}),
    };
    const [current, legacy, currentCount, legacyCount] =
      await this.freight.$transaction(async (tx) => {
        await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
        return Promise.all([
          tx.newShipment.findMany({
            where,
            include: newShipmentInclude,
            orderBy: { createdAt: 'desc' },
            take: limit + offset,
          }),
          tx.shipment.findMany({
            where,
            include: legacyShipmentInclude,
            orderBy: { createdAt: 'desc' },
            take: limit + offset,
          }),
          tx.newShipment.count({ where }),
          tx.shipment.count({ where }),
        ]);
      });
    const data = [...current, ...legacy]
      .sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime())
      .slice(offset, offset + limit)
      .map((shipment) => this.toResponse(shipment));
    return { data, total: currentCount + legacyCount };
  }

  async findRecordById(
    tenantId: Uuid,
    id: Uuid,
  ): Promise<ShipmentRecord | null> {
    return this.freight.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
      const current = await tx.newShipment.findFirst({
        where: { id, tenantId },
        include: newShipmentInclude,
      });
      if (current) return current;
      return tx.shipment.findFirst({
        where: { id, tenantId },
        include: legacyShipmentInclude,
      });
    });
  }

  async findReturnByCode(returnCode: string): Promise<ShipmentRecord | null> {
    return this.freight.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.bypass_rls', 'on', TRUE)`;
      const current = await tx.newShipment.findFirst({
        where: { returnCode },
        include: newShipmentInclude,
      });
      if (current) return current;
      return tx.shipment.findFirst({
        where: { returnCode },
        include: legacyShipmentInclude,
      });
    });
  }

  createPickupReference(): string {
    return `RET-${randomUUID()}`;
  }

  toResponse(
    shipment: ShipmentRecord,
    includeEnquiryToken = false,
  ): ShipmentResponse {
    const mapLocation = (location: ShipmentRecord['sender']['location']) =>
      compact({
        id: location.id as Uuid,
        name: toOptional(location.name),
        addressId: location.addressId as Uuid,
        tenantId: location.tenantId as Uuid,
        createdAt: location.createdAt.toISOString() as DateTimeString,
        address: {
          id: location.address.id as Uuid,
          addressLine1: location.address.addressLine1,
          addressLine2: toOptional(location.address.addressLine2),
          suburb: location.address.suburb,
          state: location.address.state,
          postcode: location.address.postcode,
          country: location.address.country,
          countryCode: toOptional(location.address.countryCode),
          tenantId: location.address.tenantId as Uuid,
          createdAt: location.address.createdAt.toISOString() as DateTimeString,
        },
        contact: location.contact
          ? compact({
              id: location.contact.id as Uuid,
              name: location.contact.name,
              email: location.contact.email as Email,
              additionalEmails: location.contact.additionalEmails as Email[],
              phoneNumber: toOptional(location.contact.phoneNumber),
              locationId: location.contact.locationId as Uuid,
              tenantId: location.contact.tenantId as Uuid,
              createdAt:
                location.contact.createdAt.toISOString() as DateTimeString,
            })
          : undefined,
      });
    const mapParty = (
      party: ShipmentRecord['sender'] | NonNullable<ShipmentRecord['receiver']>,
    ) =>
      compact({
        id: party.id as Uuid,
        name: party.name,
        locationId: party.locationId as Uuid,
        tenantId: party.tenantId as Uuid,
        createdAt: party.createdAt.toISOString() as DateTimeString,
        code: toOptional(party.code),
        isResidential: party.isResidential,
        customerGroupId:
          'customerGroupId' in party
            ? (party.customerGroupId as Uuid)
            : undefined,
        specialInstructions:
          'specialInstructions' in party
            ? toOptional(party.specialInstructions)
            : undefined,
        location: mapLocation(party.location),
      });
    const reference = shipment.shipmentReferenceId ?? shipment.reference;
    return compact({
      id: shipment.id as Uuid,
      reference: toOptional(shipment.reference),
      senderId: shipment.senderId as Uuid,
      receiverId: shipment.receiverId as Uuid,
      dispatchDate: shipment.dispatchDate.toISOString() as DateTimeString,
      signaturePreference: shipment.signaturePreference,
      billTo: shipment.billTo,
      carrier: shipment.carrier,
      serviceName: shipment.serviceName,
      serviceId: shipment.serviceId as Uuid,
      connectionId: shipment.connectionId as Uuid,
      pickupInstructions: toOptional(shipment.pickupInstructions),
      deliveryInstructions: toOptional(shipment.deliveryInstructions),
      customReference: toOptional(shipment.customReference),
      status: shipment.status,
      pickupId: toOptional(shipment.pickupId) as Uuid | undefined,
      createdAt: shipment.createdAt.toISOString() as DateTimeString,
      tenantId: shipment.tenantId as Uuid,
      accountId: shipment.accountId as Uuid,
      customerGroupId: shipment.customerGroupId as Uuid,
      shipmentReferenceId: toOptional(shipment.shipmentReferenceId),
      minBusinessDays: toOptional(shipment.minBusinessDays),
      maxBusinessDays: toOptional(shipment.maxBusinessDays),
      estimatedPrice: toDecimalString(shipment.estimatedPrice),
      updatedAt: shipment.updatedAt.toISOString() as DateTimeString,
      deleted: shipment.deleted,
      manifestId: toOptional(shipment.manifestId) as Uuid | undefined,
      consignmentReference: toOptional(shipment.consignmentReference),
      internalReference: toOptional(shipment.internalReference),
      returnCode: toOptional(shipment.returnCode),
      sender: mapParty(shipment.sender),
      receiver: shipment.receiver ? mapParty(shipment.receiver) : undefined,
      details: shipment.details
        ? compact({
            id: shipment.details.id as Uuid,
            dispatchDate: shipment.details.dispatchDate,
            deliverySignaturePreference:
              shipment.details.deliverySignaturePreference,
            billTo: shipment.details.billTo,
            carrier: shipment.details.carrier,
            serviceName: shipment.details.serviceName,
            serviceId: shipment.details.serviceId as Uuid,
            connectionId: shipment.details.connectionId as Uuid,
            specialServices: shipment.details.specialServices,
            pickupInstructions: toOptional(shipment.details.pickupInstructions),
            deliveryInstructions: toOptional(
              shipment.details.deliveryInstructions,
            ),
            customReference: toOptional(shipment.details.customReference),
            consignmentReference: toOptional(
              shipment.details.consignmentReference,
            ),
            internalReference: toOptional(shipment.details.internalReference),
            eta: toOptional(shipment.details.eta),
            thirdPartyAccountNumber: toOptional(
              shipment.details.thirdPartyAccountNumber,
            ),
            billToCustomerGroupId: toOptional(
              shipment.details.billToCustomerGroupId,
            ),
            totalVolume: toDecimalString(shipment.details.totalVolume),
            totalWeight: toDecimalString(shipment.details.totalWeight),
            totalQuantity: toOptional(shipment.details.totalQuantity),
            enableItemAsTotal: toOptional(shipment.details.enableItemAsTotal),
            isReturnEmailSent: toOptional(shipment.details.isReturnEmailSent),
            isReturnConfirmed: toOptional(shipment.details.isReturnConfirmed),
            tenantId: shipment.details.tenantId as Uuid,
            shipmentId: shipment.details.shipmentId as Uuid,
            createdAt:
              shipment.details.createdAt.toISOString() as DateTimeString,
            updatedAt:
              shipment.details.updatedAt.toISOString() as DateTimeString,
          })
        : undefined,
      packages: shipment.packages.map((pkg) =>
        compact({
          id: pkg.id as Uuid,
          name: toOptional(pkg.name),
          packageType: pkg.packageType,
          quantity: pkg.quantity,
          weight: pkg.weight.toString(),
          length: pkg.length.toString(),
          width: pkg.width.toString(),
          height: pkg.height.toString(),
          volume: toDecimalString(pkg.volume),
          reference: toOptional(pkg.reference),
          labelQuantity: pkg.labelQuantity,
          isEnablePrint: toOptional(pkg.isEnablePrint),
          tenantId: pkg.tenantId as Uuid,
          createdAt: pkg.createdAt.toISOString() as DateTimeString,
          packageContents: pkg.packageContents.map((content) =>
            compact({
              id: content.id as Uuid,
              reference: toOptional(content.reference),
              packageType: toOptional(content.packageType),
              quantity: toOptional(content.quantity),
              weight: toDecimalString(content.weight),
              dgType: toOptional(content.dgType),
              dgId: toOptional(content.dgId),
              createdAt: content.createdAt.toISOString() as DateTimeString,
              updatedAt: content.updatedAt.toISOString() as DateTimeString,
            }),
          ),
        }),
      ),
      paperwork: shipment.paperwork.map((paper) => ({
        id: paper.id as Uuid,
        fileName: paper.fileName,
        size: paper.size.toString(),
        reference: paper.reference,
        tag: paper.tag,
        tenantId: paper.tenantId as Uuid,
        createdAt: paper.createdAt.toISOString() as DateTimeString,
        lastPrintedDate: paper.lastPrintedDate.toISOString() as DateTimeString,
      })),
      palletsManagement: shipment.palletsManagement
        ? compact({
            id: shipment.palletsManagement.id as Uuid,
            accountNumber: toOptional(shipment.palletsManagement.accountNumber),
            chep: shipment.palletsManagement.chep,
            loscam: shipment.palletsManagement.loscam,
            other: shipment.palletsManagement.other,
            tenantId: shipment.palletsManagement.tenantId as Uuid,
            createdAt:
              shipment.palletsManagement.createdAt.toISOString() as DateTimeString,
          })
        : undefined,
      pickup: shipment.pickup
        ? compact({
            id: shipment.pickup.id as Uuid,
            pickupReference: shipment.pickup.pickupReference,
            pickupDate:
              shipment.pickup.pickupDate.toISOString() as DateTimeString,
            readyTime:
              shipment.pickup.readyTime.toISOString() as DateTimeString,
            closingTime: shipment.pickup.closingTime
              ? (shipment.pickup.closingTime.toISOString() as DateTimeString)
              : undefined,
            timezone: shipment.pickup.timezone,
            internalReference: toOptional(shipment.pickup.internalReference),
            pickupArea: toOptional(shipment.pickup.pickupArea),
            specialInstructions: toOptional(
              shipment.pickup.specialInstructions,
            ),
            pickupStatus: shipment.pickup.pickupStatus,
            status: toOptional(shipment.pickup.status),
            tenantId: shipment.pickup.tenantId as Uuid,
            shipmentId: toOptional(shipment.pickup.shipmentId) as
              Uuid | undefined,
            createdAt:
              shipment.pickup.createdAt.toISOString() as DateTimeString,
          })
        : undefined,
      enquiryToken:
        includeEnquiryToken && reference
          ? signTrackingValue(currentTrackingWindow(reference))
          : undefined,
    }) as ShipmentResponse;
  }
}
