import type { tags } from "typia";

import type { ShipmentPackageContent } from "./ShipmentPackageContent";

export type ShipmentPackage = {
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
  name?: undefined | string;
  packageType: string;
  quantity: number;
  weight: string;
  length: string;
  width: string;
  height: string;
  volume?: undefined | string;
  reference?: undefined | string;
  labelQuantity: number;
  isEnablePrint?: undefined | boolean;
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
  packageContents: ShipmentPackageContent[];
};
