import type { DateTimeString, Email, Uuid } from './common';

export interface TenantSummary {
  id: Uuid;
  name: string;
  firebaseId: string;
  ownerId?: Uuid;
  displayName: string;
  organisationalUnitId?: Uuid;
  bucketName?: string;
  createdAt: DateTimeString;
  updatedAt: DateTimeString;
}

export interface TenantUserSummary {
  id: Uuid;
  email: Email;
  firstName: string;
  lastName: string;
  fullName?: string;
  status: string;
  type: string;
  tenantId: Uuid;
  organisationalUnitId: Uuid;
  applicationAccess: string[];
  primaryApp?: string;
  createdAt: DateTimeString;
  updatedAt: DateTimeString;
}

export interface TenantContextResponse {
  tenant: TenantSummary;
  user?: TenantUserSummary;
  accountIds: Uuid[];
}

export interface TenantUsersQuery {
  limit?: number;
  offset?: number;
  status?: string;
  search?: string;
}

export interface TenantUsersResponse {
  data: TenantUserSummary[];
  total: number;
}

export interface AccountAccessResponse {
  tenantId: Uuid;
  accountId: Uuid;
  hasAccess: boolean;
}
