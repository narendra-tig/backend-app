import type { tags } from "typia";

import type { TrackingShipment } from "./TrackingShipment";

export type SaveTrackingEventsRequest = {
  trackingBehavior: "OVERRIDE" | "PUSH";
  tenantId: string &
    tags.TagBase<{
      target: "string";
      kind: "format";
      value: "uuid";
      validate: '$importInternal("isFormatUuid")($input)';
      exclusive: ["format", "pattern"];
      schema: {
        format: "uuid";
      };
    }>;
  shipments: TrackingShipment[];
  carrier?: undefined | string;
};
