import type { tags } from 'typia';

export type Uuid = string & tags.Format<'uuid'>;
export type DateTimeString = string & tags.Format<'date-time'>;
export type Email = string & tags.Format<'email'>;

export interface TenantHeaders {
  'x-tenant-id': Uuid;
  'x-account-id'?: Uuid;
  authorization?: string;
}

export interface InternalHeaders {
  'x-internal-api-key': string;
}

export interface TenantInternalHeaders extends TenantHeaders, InternalHeaders {}

export interface ReturnTokenHeaders {
  'x-return-token': string;
}

export interface OkResponse {
  ok: true;
}

export interface HealthResponse {
  status: 'ok';
  service: 'backend-app';
  timestamp: DateTimeString;
}

export type JsonValue =
  null | boolean | number | string | JsonValue[] | { [key: string]: JsonValue };
