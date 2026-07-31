import type { ReturnAddressInput } from "./ReturnAddressInput";
import type { ReturnContactInput } from "./ReturnContactInput";

export type ReturnSenderInput = {
  address: ReturnAddressInput;
  contact: ReturnContactInput;
  companyName: string;
  isResidential?: undefined | boolean;
};
