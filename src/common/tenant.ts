import { BadRequestException, ForbiddenException } from '@nestjs/common';
import type { TenantHeaders, Uuid } from '../contracts';

export function tenantIdFrom(headers: TenantHeaders): Uuid {
  if (!headers['x-tenant-id']) {
    throw new BadRequestException('x-tenant-id is required');
  }
  return headers['x-tenant-id'];
}

export function assertTenant(
  resourceTenantId: string,
  requestedTenantId: string,
): void {
  if (resourceTenantId !== requestedTenantId) {
    throw new ForbiddenException('Resource does not belong to this tenant');
  }
}
