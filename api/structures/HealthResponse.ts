import type { tags } from "typia";

export type HealthResponse = {
  status: "ok";
  service: "backend-app";
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
};
