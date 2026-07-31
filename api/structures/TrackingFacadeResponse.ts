import type { AccountSummary } from "./AccountSummary";
import type { Branding } from "./Branding";
import type { CarrierSummary } from "./CarrierSummary";
import type { ShipmentResponse } from "./ShipmentResponse";
import type { TrackingEventResponse } from "./TrackingEventResponse";

export type TrackingFacadeResponse = {
  shipment: ShipmentResponse;
  tracking: TrackingEventResponse[];
  account?: undefined | AccountSummary;
  supplier?: undefined | CarrierSummary;
  branding?: undefined | Branding;
};
