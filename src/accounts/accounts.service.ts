import { Injectable, NotFoundException } from '@nestjs/common';
import type {
  AccountListQuery,
  AccountListResponse,
  AccountSummary,
  UpdateAccountRequest,
  Uuid,
} from '../contracts';
import { compact, toOptional } from '../common/json';
import { AccountsPrismaService } from '../prisma/accounts-prisma.service';
import type { Account } from '../../models/accounts/client';

@Injectable()
export class AccountsService {
  constructor(private readonly accountsPrismaService: AccountsPrismaService) {}

  async list(
    tenantId: Uuid,
    query: AccountListQuery,
  ): Promise<AccountListResponse> {
    const limit = Math.min(Math.max(query.limit ?? 50, 1), 200);
    const offset = Math.max(query.offset ?? 0, 0);
    const where = {
      tenantId,
      ...(query.status ? { status: query.status as never } : {}),
      ...(query.search
        ? {
            OR: [
              {
                name: { contains: query.search, mode: 'insensitive' as const },
              },
              {
                displayName: {
                  contains: query.search,
                  mode: 'insensitive' as const,
                },
              },
            ],
          }
        : {}),
    };
    const [rows, total] = await this.accountsPrismaService.$transaction(
      async (tx) => {
        await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
        return Promise.all([
          tx.account.findMany({
            where,
            orderBy: { displayName: 'asc' },
            take: limit,
            skip: offset,
          }),
          tx.account.count({ where }),
        ]);
      },
    );
    return { data: rows.map((row) => this.toSummary(row)), total };
  }

  async findOne(tenantId: Uuid, accountId: Uuid): Promise<AccountSummary> {
    const account = await this.accountsPrismaService.$transaction(
      async (tx) => {
        await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
        return tx.account.findFirst({ where: { id: accountId, tenantId } });
      },
    );
    if (!account) throw new NotFoundException('Account not found');
    return this.toSummary(account);
  }

  async findByName(name: string): Promise<AccountSummary> {
    const account = await this.accountsPrismaService.$transaction(
      async (tx) => {
        await tx.$executeRaw`SELECT set_config('app.bypass_rls', 'on', TRUE)`;
        return tx.account.findUnique({ where: { name } });
      },
    );
    if (!account) throw new NotFoundException('Account not found');
    return this.toSummary(account);
  }

  async update(
    tenantId: Uuid,
    accountId: Uuid,
    input: UpdateAccountRequest,
  ): Promise<AccountSummary> {
    const account = await this.accountsPrismaService.$transaction(
      async (tx) => {
        await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
        const exists = await tx.account.findFirst({
          where: { id: accountId, tenantId },
          select: { id: true },
        });
        if (!exists) throw new NotFoundException('Account not found');
        return tx.account.update({
          where: { id: accountId },
          data: {
            displayName: input.displayName,
            icon: input.icon,
            backgroundImage: input.backgroundImage,
            about: input.about,
            logo: input.logo,
            status: input.status,
            isMFAEnabled: input.isMfaEnabled,
            isSSOEnabled: input.isSsoEnabled,
            standing: input.standing,
            grade: input.grade,
            type: input.type,
          },
        });
      },
    );
    return this.toSummary(account);
  }

  private toSummary(account: Account): AccountSummary {
    return compact({
      id: account.id as Uuid,
      name: account.name,
      displayName: account.displayName,
      icon: toOptional(account.icon),
      backgroundImage: toOptional(account.backgroundImage),
      about: toOptional(account.about),
      status: account.status,
      customerGroupId: toOptional(account.customerGroupId) as Uuid | undefined,
      tenantId: account.tenantId as Uuid,
      logo: toOptional(account.logo),
      billingCode: toOptional(account.billingCode),
      isMfaEnabled: account.isMFAEnabled,
      isSsoEnabled: account.isSSOEnabled,
      standing: toOptional(account.standing),
      grade: toOptional(account.grade),
      type: account.type,
      createdAt: account.createdAt.toISOString(),
      updatedAt: account.updatedAt.toISOString(),
    }) as AccountSummary;
  }
}
