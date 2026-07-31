export type ReturnPickupInput = {
  pickupDate: string;
  readyTime: string;
  closingTime: string;
  timezone: string;
  internalReference?: undefined | string;
  pickupArea?: undefined | string;
  specialInstructions?: undefined | string;
};
