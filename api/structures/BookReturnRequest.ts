import type { ReturnPackageInput } from "./ReturnPackageInput";
import type { ReturnPickupInput } from "./ReturnPickupInput";
import type { ReturnSenderInput } from "./ReturnSenderInput";

export type BookReturnRequest = {
  sender: ReturnSenderInput;
  packages: ReturnPackageInput[];
  pickup: ReturnPickupInput;
};
