export type CreateAccountDto = {
  name: string;
  tenantId: string;
  displayName: string;
  ofTenancy?: undefined | string;
  standing?: undefined | "HEALTHY" | "HYPERCARE" | "NEW" | "STANDARD";
  grade?: undefined | "A" | "B" | "C" | "D" | "X";
};
