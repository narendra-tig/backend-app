import type { Email, OkResponse, Uuid } from './common';

export interface EnquiryType {
  id: number;
  value: string;
}

export interface CreateTrackingEnquiryRequest {
  name: string;
  email: Email;
  phone: string;
  type: string;
  message: string;
  shipmentId: Uuid;
  shipmentReference: string;
  token: string;
  billingCode?: number;
}

export interface CreateTrackingEnquiryResponse extends OkResponse {
  forwarded: boolean;
}
