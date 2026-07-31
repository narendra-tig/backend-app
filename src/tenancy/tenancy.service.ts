import { Injectable, NotFoundException } from '@nestjs/common';
import type {
  AccountAccessResponse,
  DateTimeString,
  Email,
  TenantContextResponse,
  TenantSummary,
  TenantUserSummary,
  TenantUsersQuery,
  TenantUsersResponse,
  Uuid,
} from '../contracts';
import { compact, toOptional } from '../common/json';
import { AccountsPrismaService } from '../prisma/accounts-prisma.service';
import { CorePrismaService } from '../prisma/core-prisma.service';
import type { Tenant, User } from '../../models/core/client';

@Injectable()
export class TenancyService {
  constructor(
    private readonly core: CorePrismaService,
    private readonly accounts: AccountsPrismaService,
  ) {}

  async getTenant(tenantId: Uuid): Promise<TenantSummary> {
    const tenant = await this.core.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
      return tx.tenant.findUnique({
        where: { id: tenantId },
        include: { details: true },
      });
    });
    if (!tenant) throw new NotFoundException('Tenant not found');
    return this.toTenant(tenant);
  }

  async getContext(
    tenantId: Uuid,
    userId?: Uuid,
  ): Promise<TenantContextResponse> {
    const [tenant, user, accountUsers] = await this.core.$transaction(
      async (tx) => {
        await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
        return Promise.all([
          tx.tenant.findUnique({
            where: { id: tenantId },
            include: { details: true },
          }),
          userId
            ? tx.user.findFirst({ where: { id: userId, tenantId } })
            : null,
          userId
            ? tx.accountUser.findMany({
                where: { userId, tenantId, accountId: { not: null } },
                select: { accountId: true },
              })
            : Promise.resolve([] as Array<{ accountId: string | null }>),
        ]);
      },
    );
    if (!tenant) throw new NotFoundException('Tenant not found');
    if (userId && !user) throw new NotFoundException('User not found');
    return compact({
      tenant: this.toTenant(tenant),
      user: user ? this.toUser(user) : undefined,
      accountIds: accountUsers
        .map((row) => row.accountId)
        .filter((id): id is string => id !== null) as Uuid[],
    });
  }

  async listUsers(
    tenantId: Uuid,
    query: TenantUsersQuery,
  ): Promise<TenantUsersResponse> {
    const limit = Math.min(Math.max(query.limit ?? 50, 1), 200);
    const offset = Math.max(query.offset ?? 0, 0);
    const where = {
      tenantId,
      deletedAt: null,
      ...(query.status ? { status: query.status as never } : {}),
      ...(query.search
        ? {
            OR: [
              {
                email: { contains: query.search, mode: 'insensitive' as const },
              },
              {
                firstName: {
                  contains: query.search,
                  mode: 'insensitive' as const,
                },
              },
              {
                lastName: {
                  contains: query.search,
                  mode: 'insensitive' as const,
                },
              },
            ],
          }
        : {}),
    };
    const [rows, total] = await this.core.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
      return Promise.all([
        tx.user.findMany({
          where,
          take: limit,
          skip: offset,
          orderBy: [{ firstName: 'asc' }, { lastName: 'asc' }],
        }),
        tx.user.count({ where }),
      ]);
    });
    return { data: rows.map((row) => this.toUser(row)), total };
  }

  async verifyAccountAccess(
    tenantId: Uuid,
    accountId: Uuid,
    userId?: Uuid,
  ): Promise<AccountAccessResponse> {
    const account = await this.accounts.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
      return tx.account.findFirst({
        where: { id: accountId, tenantId },
        select: { id: true },
      });
    });
    if (!account) {
      return { tenantId, accountId, hasAccess: false };
    }
    if (!userId) return { tenantId, accountId, hasAccess: true };
    const access = await this.core.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
      return tx.accountUser.findFirst({
        where: { userId, tenantId, accountId },
        select: { id: true },
      });
    });
    return { tenantId, accountId, hasAccess: Boolean(access) };
  }

  private toTenant(
    tenant: Tenant & { details?: { bucketName: string } | null },
  ): TenantSummary {
    return compact({
      id: tenant.id as Uuid,
      name: tenant.name,
      firebaseId: tenant.firebaseId,
      ownerId: toOptional(tenant.ownerId) as Uuid | undefined,
      displayName: tenant.displayName,
      organisationalUnitId: toOptional(tenant.organisationalUnitId) as
        Uuid | undefined,
      bucketName: toOptional(tenant.details?.bucketName),
      createdAt: tenant.createdAt.toISOString() as DateTimeString,
      updatedAt: tenant.updatedAt.toISOString() as DateTimeString,
    });
  }

  private toUser(user: User): TenantUserSummary {
    return compact({
      id: user.id as Uuid,
      email: user.email as Email,
      firstName: user.firstName,
      lastName: user.lastName,
      fullName: toOptional(user.fullName),
      status: user.status,
      type: user.type,
      tenantId: user.tenantId as Uuid,
      organisationalUnitId: user.organisationalUnitId as Uuid,
      applicationAccess: user.applicationAccess,
      primaryApp: toOptional(user.primaryApp),
      createdAt: user.createdAt.toISOString() as DateTimeString,
      updatedAt: user.updatedAt.toISOString() as DateTimeString,
    });
  }
}
