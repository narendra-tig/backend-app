import type { tags } from "typia";

import type { TenantSummary } from "./TenantSummary";
import type { TenantUserSummary } from "./TenantUserSummary";

export type TenantContextResponse = {
  tenant: TenantSummary;
  user?: undefined | TenantUserSummary;
  accountIds: (string &
    tags.TagBase<{
      target: "string";
      kind: "format";
      value: "uuid";
      validate: '$importInternal("isFormatUuid")($input)';
      exclusive: ["format", "pattern"];
      schema: {
        format: "uuid";
      };
    }>)[];
};
