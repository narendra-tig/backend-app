import type { tags } from "typia";

export type TenantContextQuery = {
  userId?:
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
};
