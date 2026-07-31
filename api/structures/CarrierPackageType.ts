import type { tags } from "typia";

export type CarrierPackageType = {
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
  masterCarrierId: string &
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
  carrierName: string;
  displayName: string;
  name: string;
  platformType: string;
  lengthMin?: undefined | number;
  lengthMax?: undefined | number;
  heightMin?: undefined | number;
  heightMax?: undefined | number;
  widthMin?: undefined | number;
  widthMax?: undefined | number;
  volumeMin?: undefined | number;
  volumeMax?: undefined | number;
  weightMin?: undefined | number;
  weightMax?: undefined | number;
  cubicMin?: undefined | number;
  cubicMax?: undefined | number;
};
