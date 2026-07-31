import type { tags } from "typia";

export type ShipmentListQuery = {
  accountId?:
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
  customerGroupId?:
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
  status?: undefined | string;
  reference?: undefined | string;
  limit?: undefined | number;
  offset?: undefined | number;
};
