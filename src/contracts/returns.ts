import type { Email, Uuid } from './common';
import type { AccountSummary } from './accounts';
import type { CarrierSummary } from './carriers';
import type { ShipmentResponse } from './shipments';
import type { Branding, TrackingEventResponse } from './tracking';

export interface ValidateReturnRequest {
  returnCode: string;
  validationNumber: string;
}

export interface ValidateReturnResponse {
  returnCode: string;
  token: string;
  expiresInSeconds: number;
}

export interface ReturnAddressInput {
  addressLine1: string;
  addressLine2?: string;
  suburb: string;
  state: string;
  postcode: string;
  type?: 'BUSINESS' | 'RESIDENTIAL';
  countryCode?: string;
}

export interface ReturnContactInput {
  name: string;
  email: Email;
  additionalEmails?: Email[];
  phoneNumber?: string;
}

export interface ReturnSenderInput {
  address: ReturnAddressInput;
  contact: ReturnContactInput;
  companyName: string;
  isResidential?: boolean;
}

export interface ReturnPackageInput {
  reference?: string;
  name: string;
  packageType: string;
  weight: number;
  length: number;
  width: number;
  height: number;
  quantity: number;
  id?: Uuid;
}

export interface ReturnPickupInput {
  pickupDate: string;
  readyTime: string;
  closingTime: string;
  timezone: string;
  internalReference?: string;
  pickupArea?: string;
  specialInstructions?: string;
}

export interface BookReturnRequest {
  sender: ReturnSenderInput;
  packages: ReturnPackageInput[];
  pickup: ReturnPickupInput;
}

export interface ReturnShipmentView {
  shipment: ShipmentResponse;
  tracking: TrackingEventResponse[];
  account: AccountSummary;
  supplier: CarrierSummary;
  branding: Branding;
}
