export type UpdateAccountRequest = {
  displayName?: undefined | string;
  icon?: null | undefined | string;
  backgroundImage?: null | undefined | string;
  about?: null | undefined | string;
  logo?: null | undefined | string;
  status?: undefined | "ACTIVE" | "ARCHIVED" | "INACTIVE" | "PENDING";
  isMfaEnabled?: undefined | boolean;
  isSsoEnabled?: undefined | boolean;
  standing?: null | undefined | "HEALTHY" | "HYPERCARE" | "NEW" | "STANDARD";
  grade?: null | undefined | "A" | "B" | "C" | "D" | "X";
  type?: undefined | "B2B" | "B2C" | "MANAGED" | "SAAS";
};
