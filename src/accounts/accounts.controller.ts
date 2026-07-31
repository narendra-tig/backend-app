import { Controller, UseGuards } from '@nestjs/common';
import {
  TypedBody,
  TypedHeaders,
  TypedParam,
  TypedQuery,
  TypedRoute,
} from '@nestia/core';
import type {
  AccountListQuery,
  AccountListResponse,
  AccountSummary,
  TenantHeaders,
  UpdateAccountRequest,
  Uuid,
} from '../contracts';
import { tenantIdFrom } from '../common/tenant';
import { TenantAuthGuard } from '../common/tenant-auth.guard';
import { AccountsService } from './accounts.service';

@Controller('v1/accounts')
export class AccountsController {
  constructor(private readonly accountsService: AccountsService) {}

  @TypedRoute.Get()
  @UseGuards(TenantAuthGuard)
  list(
    @TypedHeaders() headers: TenantHeaders,
    @TypedQuery() query: AccountListQuery,
  ): Promise<AccountListResponse> {
    return this.accountsService.list(tenantIdFrom(headers), query);
  }

  @TypedRoute.Get('by-name/:name')
  findByName(@TypedParam('name') name: string): Promise<AccountSummary> {
    return this.accountsService.findByName(name);
  }

  @TypedRoute.Get(':accountId')
  @UseGuards(TenantAuthGuard)
  findOne(
    @TypedHeaders() headers: TenantHeaders,
    @TypedParam('accountId') accountId: Uuid,
  ): Promise<AccountSummary> {
    return this.accountsService.findOne(tenantIdFrom(headers), accountId);
  }

  @TypedRoute.Patch(':accountId')
  @UseGuards(TenantAuthGuard)
  update(
    @TypedHeaders() headers: TenantHeaders,
    @TypedParam('accountId') accountId: Uuid,
    @TypedBody() input: UpdateAccountRequest,
  ): Promise<AccountSummary> {
    return this.accountsService.update(tenantIdFrom(headers), accountId, input);
  }
}
