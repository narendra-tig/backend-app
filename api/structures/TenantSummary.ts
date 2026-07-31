import type { tags } from "typia";

export type TenantSummary = {
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
  name: string;
  firebaseId: string;
  ownerId?:
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
  displayName: string;
  organisationalUnitId?:
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
  bucketName?: undefined | string;
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
  updatedAt: string &
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
