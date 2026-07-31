import type { tags } from "typia";

export type ShipmentPickup = {
  id: string &
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
  pickupReference: string;
  pickupDate: string &
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
  readyTime: string &
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
  closingTime?:
    | undefined
    | (string &
        tags.TagBase<{
          target: "string";
          kind: "format";
          value: "date-time";
          validate: '$importInternal("isFormatDateTime")($input)';
          exclusive: ["format", "pattern"];
          schema: {
            format: "date-time";
          };
        }>);
  timezone: string;
  internalReference?: undefined | string;
  pickupArea?: undefined | string;
  specialInstructions?: undefined | string;
  pickupStatus: string;
  status?: undefined | string;
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
  shipmentId?:
    | undefined
    | (string &
        tags.TagBase<{
          target: "string";
          kind: "format";
          value: "uuid";
          validate: '$importInternal("isFormatUuid")($input)';
          exclusive: ["format", "pattern"];
          schema: {
            format: "uuid";
          };
        }>);
  createdAt: string &
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
};
