import type { tags } from "typia";

export type ReturnContactInput = {
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
  additionalEmails?:
    | undefined
    | (string &
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
};
