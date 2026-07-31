import type { tags } from "typia";

import type { TrackingLevelOfDetail } from "./TrackingLevelOfDetail";

export type TrackingEventResponse = {
  shipmentId: string &
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
  carrier: string;
  timestamp: string &
    tags.TagBase<{
      target: "string";
      kind: "format";
      value: "date-time";
      validate: '$importInternal("isFormatDateTime")($input)';
      exclusive: ["format", "pattern"];
      schema: {
        format: "date-time";
      };
    }>;
  location: string;
  packageRef?: undefined | string;
  level0: TrackingLevelOfDetail;
  level1?: undefined | TrackingLevelOfDetail;
};
