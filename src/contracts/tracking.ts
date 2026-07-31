import type { DateTimeString, Uuid } from './common';

export interface TrackingLevelOfDetail {
  id?: Uuid;
  name: string;
  description: string;
}

export interface TrackingEventResponse {
  shipmentId: Uuid;
  tenantId: Uuid;
  carrier: string;
  timestamp: DateTimeString;
  location: string;
  packageRef?: string;
  level0: TrackingLevelOfDetail;
  level1?: TrackingLevelOfDetail;
}

export interface TrackingEventsResponse {
  trackingEvents: TrackingEventResponse[];
}

export interface PersistTrackingEvent {
  shipmentId: Uuid;
  tenantId: Uuid;
  timestamp: DateTimeString;
  location: string;
  packageRef?: string;
  trackingEventId: Uuid;
  connectionId?: Uuid;
  consignmentId?: string;
}

export interface TrackingShipment {
  shipmentId: Uuid;
  delivered: boolean;
  events: PersistTrackingEvent[];
  connectionId: Uuid;
  consignmentId?: string;
  tenantId: Uuid;
  notifiedEvents: string[];
  data?: unknown;
  accountId: Uuid;
  carrier?: string;
}

export interface TrackingShipmentsResponse {
  shipments: TrackingShipment[];
}

export interface SaveTrackingEventsRequest {
  trackingBehavior: 'PUSH' | 'OVERRIDE';
  tenantId: Uuid;
  shipments: TrackingShipment[];
  carrier?: string;
}

export interface UpdateDeliveredShipmentRequest {
  delivered: boolean;
}

export interface RegisterTrackingShipmentRequest {
  carrier: string;
  consignmentId: string;
  connectionId: Uuid;
  accountId: Uuid;
  data?: unknown;
}

export interface SaveNotifiedEventRequest {
  status: string;
  isDelivered?: boolean;
}

export interface TrackingFacadeResponse {
  shipment: import('./shipments').ShipmentResponse;
  tracking: TrackingEventResponse[];
  account?: import('./accounts').AccountSummary;
  supplier?: import('./carriers').CarrierSummary;
  branding?: Branding;
}

export interface Branding {
  logo?: string;
  logoLink?: string;
  logoPosition?:
    | 'top-right'
    | 'top-left'
    | 'bottom-left'
    | 'bottom-right'
    | 'top-center'
    | 'bottom-center';
  background?: string;
  heading?: string;
  theme?: string;
}
