import type { tags } from "typia";

export type SuburbLocation = {
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
  locality?: undefined | string;
  suburb: string;
  state: string;
  postcode: string;
  countryCode?: undefined | string;
  country: string;
  latitude?: undefined | number;
  longitude?: undefined | number;
};
