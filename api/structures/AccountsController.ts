export namespace AccountsController {
  export type __type = {
    id: string;
    ofAccountId: null | string;
    name: string;
    displayName: string;
    icon: null | string;
    backgroundImage: null | string;
    about: null | string;
    createdAt: string;
    updatedAt: string;
    customerGroupId: null | string;
    tenantId: string;
    status: "ACTIVE" | "ARCHIVED" | "INACTIVE" | "PENDING";
    billingCode: null | number;
    ofBillingCode: null | number;
    logo: null | string;
    isMFAEnabled: boolean;
    isSSOEnabled: boolean;
    ofTenancy: null | string;
    standing: null | "HEALTHY" | "HYPERCARE" | "NEW" | "STANDARD";
    grade: null | "A" | "B" | "C" | "D" | "X";
    type: "B2B" | "B2C" | "MANAGED" | "SAAS";
  };
}
