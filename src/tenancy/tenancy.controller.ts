import { Controller, UseGuards } from '@nestjs/common';
import { TypedHeaders, TypedParam, TypedQuery, TypedRoute } from '@nestia/core';
import { tenantIdFrom } from '../common/tenant';
import { TenantAuthGuard } from '../common/tenant-auth.guard';
import type {
  AccountAccessResponse,
  TenantContextResponse,
  TenantHeaders,
  TenantSummary,
  TenantUsersQuery,
  TenantUsersResponse,
  Uuid,
} from '../contracts';
import { TenancyService } from './tenancy.service';

interface TenantContextQuery {
  userId?: Uuid;
}

@Controller('v1/tenancy')
@UseGuards(TenantAuthGuard)
export class TenancyController {
  constructor(private readonly tenancy: TenancyService) {}

  @TypedRoute.Get('tenant')
  getTenant(@TypedHeaders() headers: TenantHeaders): Promise<TenantSummary> {
    return this.tenancy.getTenant(tenantIdFrom(headers));
  }

  @TypedRoute.Get('context')
  getContext(
    @TypedHeaders() headers: TenantHeaders,
    @TypedQuery() query: TenantContextQuery,
  ): Promise<TenantContextResponse> {
    return this.tenancy.getContext(tenantIdFrom(headers), query.userId);
  }

  @TypedRoute.Get('users')
  listUsers(
    @TypedHeaders() headers: TenantHeaders,
    @TypedQuery() query: TenantUsersQuery,
  ): Promise<TenantUsersResponse> {
    return this.tenancy.listUsers(tenantIdFrom(headers), query);
  }

  @TypedRoute.Get('accounts/:accountId/access')
  verifyAccountAccess(
    @TypedHeaders() headers: TenantHeaders,
    @TypedParam('accountId') accountId: Uuid,
    @TypedQuery() query: TenantContextQuery,
  ): Promise<AccountAccessResponse> {
    return this.tenancy.verifyAccountAccess(
      tenantIdFrom(headers),
      accountId,
      query.userId,
    );
  }
}
