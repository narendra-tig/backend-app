import type { tags } from "typia";

export type CarrierSummary = {
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
  displayName: string;
  status: string;
  previousStatus: string;
  notes?: undefined | string;
  refShortHand?: undefined | string;
  isActivated: boolean;
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
