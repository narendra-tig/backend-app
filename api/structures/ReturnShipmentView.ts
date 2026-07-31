import type { AccountSummary } from "./AccountSummary";
import type { Branding } from "./Branding";
import type { CarrierSummary } from "./CarrierSummary";
import type { ShipmentResponse } from "./ShipmentResponse";
import type { TrackingEventResponse } from "./TrackingEventResponse";

export type ReturnShipmentView = {
  shipment: ShipmentResponse;
  tracking: TrackingEventResponse[];
  account: AccountSummary;
  supplier: CarrierSummary;
  branding: Branding;
};
