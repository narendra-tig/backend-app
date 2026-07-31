import type { DateTimeString, Uuid } from './common';

export interface AccountSummary {
  id: Uuid;
  name: string;
  displayName: string;
  icon?: string;
  backgroundImage?: string;
  about?: string;
  status: string;
  customerGroupId?: Uuid;
  tenantId: Uuid;
  logo?: string;
  billingCode?: number;
  isMfaEnabled: boolean;
  isSsoEnabled: boolean;
  standing?: string;
  grade?: string;
  type: string;
  createdAt: DateTimeString;
  updatedAt: DateTimeString;
}

export interface AccountListQuery {
  status?: string;
  search?: string;
  limit?: number;
  offset?: number;
}

export interface AccountListResponse {
  data: AccountSummary[];
  total: number;
}

export interface UpdateAccountRequest {
  displayName?: string;
  icon?: string | null;
  backgroundImage?: string | null;
  about?: string | null;
  logo?: string | null;
  status?: 'PENDING' | 'ACTIVE' | 'INACTIVE' | 'ARCHIVED';
  isMfaEnabled?: boolean;
  isSsoEnabled?: boolean;
  standing?: 'HEALTHY' | 'STANDARD' | 'NEW' | 'HYPERCARE' | null;
  grade?: 'A' | 'B' | 'C' | 'D' | 'X' | null;
  type?: 'MANAGED' | 'SAAS' | 'B2B' | 'B2C';
}
