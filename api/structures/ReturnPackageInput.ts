import type { tags } from "typia";

export type ReturnPackageInput = {
  reference?: undefined | string;
  name: string;
  packageType: string;
  weight: number;
  length: number;
  width: number;
  height: number;
  quantity: number;
  id?:
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
