import type { DateTimeString, Email, Uuid } from './common';

export interface ShipmentAddress {
  id: Uuid;
  addressLine1: string;
  addressLine2?: string;
  suburb: string;
  state: string;
  postcode: string;
  country: string;
  countryCode?: string;
  tenantId: Uuid;
  createdAt: DateTimeString;
}

export interface ShipmentContact {
  id: Uuid;
  name: string;
  email: Email;
  additionalEmails: Email[];
  phoneNumber?: string;
  locationId: Uuid;
  tenantId: Uuid;
  createdAt: DateTimeString;
}

export interface ShipmentLocation {
  id: Uuid;
  name?: string;
  addressId: Uuid;
  tenantId: Uuid;
  createdAt: DateTimeString;
  address: ShipmentAddress;
  contact?: ShipmentContact;
}

export interface ShipmentParty {
  id: Uuid;
  name: string;
  locationId: Uuid;
  tenantId: Uuid;
  createdAt: DateTimeString;
  code?: string;
  isResidential: boolean;
  customerGroupId?: Uuid;
  specialInstructions?: string;
  location: ShipmentLocation;
}

export interface ShipmentPackageContent {
  id: Uuid;
  reference?: string;
  packageType?: string;
  quantity?: number;
  weight?: string;
  dgType?: string;
  dgId?: string;
  createdAt: DateTimeString;
  updatedAt: DateTimeString;
}

export interface ShipmentPackage {
  id: Uuid;
  name?: string;
  packageType: string;
  quantity: number;
  weight: string;
  length: string;
  width: string;
  height: string;
  volume?: string;
  reference?: string;
  labelQuantity: number;
  isEnablePrint?: boolean;
  tenantId: Uuid;
  createdAt: DateTimeString;
  packageContents: ShipmentPackageContent[];
}

export interface ShipmentPaperwork {
  id: Uuid;
  fileName: string;
  size: string;
  reference: string;
  tag: string;
  tenantId: Uuid;
  createdAt: DateTimeString;
  lastPrintedDate: DateTimeString;
}

export interface PalletsManagement {
  id: Uuid;
  accountNumber?: string;
  chep: number;
  loscam: number;
  other: number;
  tenantId: Uuid;
  createdAt: DateTimeString;
}

export interface ShipmentDetails {
  id: Uuid;
  dispatchDate: string;
  deliverySignaturePreference: string;
  billTo: string;
  carrier: string;
  serviceName: string;
  serviceId: Uuid;
  connectionId: Uuid;
  specialServices: string[];
  pickupInstructions?: string;
  deliveryInstructions?: string;
  customReference?: string;
  consignmentReference?: string;
  internalReference?: string;
  eta?: string;
  thirdPartyAccountNumber?: string;
  billToCustomerGroupId?: string;
  totalVolume?: string;
  totalWeight?: string;
  totalQuantity?: number;
  enableItemAsTotal?: boolean;
  isReturnEmailSent?: boolean;
  isReturnConfirmed?: boolean;
  tenantId: Uuid;
  shipmentId: Uuid;
  createdAt: DateTimeString;
  updatedAt: DateTimeString;
}

export interface ShipmentPickup {
  id: Uuid;
  pickupReference: string;
  pickupDate: DateTimeString;
  readyTime: DateTimeString;
  closingTime?: DateTimeString;
  timezone: string;
  internalReference?: string;
  pickupArea?: string;
  specialInstructions?: string;
  pickupStatus: string;
  status?: string;
  tenantId: Uuid;
  shipmentId?: Uuid;
  createdAt: DateTimeString;
}

export interface ShipmentResponse {
  id: Uuid;
  reference?: string;
  senderId: Uuid;
  receiverId: Uuid;
  dispatchDate: DateTimeString;
  signaturePreference: string;
  billTo: string;
  carrier: string;
  serviceName: string;
  serviceId: Uuid;
  connectionId: Uuid;
  pickupInstructions?: string;
  deliveryInstructions?: string;
  customReference?: string;
  status: string;
  pickupId?: Uuid;
  createdAt: DateTimeString;
  tenantId: Uuid;
  accountId: Uuid;
  customerGroupId: Uuid;
  shipmentReferenceId?: string;
  minBusinessDays?: number;
  maxBusinessDays?: number;
  estimatedPrice?: string;
  updatedAt: DateTimeString;
  deleted: boolean;
  manifestId?: Uuid;
  consignmentReference?: string;
  internalReference?: string;
  returnCode?: string;
  sender: ShipmentParty;
  receiver?: ShipmentParty;
  details?: ShipmentDetails;
  packages: ShipmentPackage[];
  paperwork: ShipmentPaperwork[];
  palletsManagement?: PalletsManagement;
  pickup?: ShipmentPickup;
  enquiryToken?: string;
  cutOffTime?: string;
}

export interface ShipmentListQuery {
  accountId?: Uuid;
  customerGroupId?: Uuid;
  status?: string;
  reference?: string;
  limit?: number;
  offset?: number;
}

export interface ShipmentListResponse {
  data: ShipmentResponse[];
  total: number;
}
