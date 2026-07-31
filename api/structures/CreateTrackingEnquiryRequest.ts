import type { tags } from "typia";

export type CreateTrackingEnquiryRequest = {
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
  phone: string;
  type: string;
  message: string;
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
  shipmentReference: string;
  token: string;
  billingCode?: undefined | number;
};
