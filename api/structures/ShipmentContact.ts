import type { tags } from "typia";

export type ShipmentContact = {
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
  email: string &
    tags.TagBase<{
      target: "string";
      kind: "format";
      value: "email";
      validate: '$importInternal("isFormatEmail")($input)';
      exclusive: ["format", "pattern"];
      schema: {
        format: "email";
      };
    }>;
  additionalEmails: (string &
    tags.TagBase<{
      target: "string";
      kind: "format";
      value: "email";
      validate: '$importInternal("isFormatEmail")($input)';
      exclusive: ["format", "pattern"];
      schema: {
        format: "email";
      };
    }>)[];
  phoneNumber?: undefined | string;
  locationId: string &
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
