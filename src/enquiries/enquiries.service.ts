import {
  BadGatewayException,
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import type {
  CreateTrackingEnquiryRequest,
  CreateTrackingEnquiryResponse,
  EnquiryType,
} from '../contracts';
import { currentTrackingWindow, verifyTrackingValue } from '../common/token';
import { AccountsPrismaService } from '../prisma/accounts-prisma.service';
import { ShipmentsService } from '../shipments/shipments.service';
import { HelpDeskClient } from './help-desk.client';

const ENQUIRY_TYPES: EnquiryType[] = [
  { id: 14, value: 'Additional Delivery Instructions' },
  { id: 15, value: 'ATL Request' },
  { id: 16, value: 'Cancel Consignment' },
  { id: 17, value: 'Check Address' },
  { id: 18, value: 'Contact Details Required' },
  { id: 19, value: 'Damaged Freight' },
  { id: 20, value: 'Depot Collection' },
  { id: 36, value: 'ETA Request' },
  { id: 21, value: 'Lost in Transit' },
  { id: 22, value: 'Missed Pick-Up' },
  { id: 23, value: 'Missing Paperwork' },
  { id: 24, value: 'Monitor' },
  { id: 25, value: 'Partial Lost in Transit' },
  { id: 35, value: 'POD Request' },
  { id: 26, value: 'Pre-alert' },
  { id: 40, value: 'Other' },
  { id: 41, value: 'Receiver Closed' },
  { id: 37, value: 'Receiver Details Incorrect' },
  { id: 27, value: 'Redelivery Required' },
  { id: 38, value: 'Redirect Freight' },
  { id: 39, value: 'Refused Freight' },
  { id: 28, value: 'Report' },
  { id: 29, value: 'Return to Sender' },
  { id: 30, value: 'Short Delivery' },
  { id: 42, value: 'Unable to Access Premises' },
  { id: 31, value: 'WOP Letter' },
];

@Injectable()
export class EnquiriesService {
  constructor(
    private readonly accounts: AccountsPrismaService,
    private readonly shipments: ShipmentsService,
    private readonly helpDesk: HelpDeskClient,
  ) {}

  getTypes(): EnquiryType[] {
    return ENQUIRY_TYPES;
  }

  async create(
    input: CreateTrackingEnquiryRequest,
  ): Promise<CreateTrackingEnquiryResponse> {
    if (
      !verifyTrackingValue(
        currentTrackingWindow(input.shipmentReference),
        input.token,
      )
    ) {
      throw new BadRequestException('Invalid tracking enquiry token');
    }
    const shipment = await this.shipments.findByReference(
      input.shipmentReference,
    );
    if (shipment.id !== input.shipmentId) {
      throw new BadRequestException('Shipment reference does not match ID');
    }
    const account = await this.accounts.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.bypass_rls', 'on', TRUE)`;
      return input.billingCode
        ? tx.account.findFirst({
            where: {
              OR: [
                { billingCode: input.billingCode },
                { ofBillingCode: input.billingCode },
              ],
            },
            include: { customerGroups: true },
          })
        : tx.account.findUnique({
            where: { id: shipment.accountId },
            include: { customerGroups: true },
          });
    });
    if (!account) throw new NotFoundException('Account not found');

    try {
      await this.helpDesk.createEnquiry({
        email: input.email,
        phone: input.phone,
        subject: input.shipmentReference,
        description: input.message,
        organisationalUnitId:
          account.customerGroups[0]?.organisationalUnitId ?? '',
        freightDescription: '',
        type: input.type,
        status: 'OPEN',
        priority: 'MEDIUM',
        attachments: [],
        name: input.name,
        jobTitle: '',
        shipmentId: input.shipmentId,
        shipmentReference: input.shipmentReference,
        billingCode:
          account.customerGroups[0]?.billingCode ?? account.billingCode,
        source: 'TRACKING',
      });
    } catch (error) {
      throw new BadGatewayException('Help desk rejected enquiry', {
        cause: error,
      });
    }
    return { ok: true, forwarded: true };
  }
}
