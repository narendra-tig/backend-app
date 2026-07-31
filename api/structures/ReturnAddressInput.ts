export type ReturnAddressInput = {
  addressLine1: string;
  addressLine2?: undefined | string;
  suburb: string;
  state: string;
  postcode: string;
  type?: undefined | "BUSINESS" | "RESIDENTIAL";
  countryCode?: undefined | string;
};
