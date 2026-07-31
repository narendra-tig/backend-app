import { Injectable } from '@nestjs/common';
import { CreateAccountDto } from './dto/create-account.dto';
import { UpdateAccountDto } from './dto/update-account.dto';
import { AccountsPrismaService } from '../prisma/accounts-prisma.service';

@Injectable()
export class AccountsService {
  constructor(private readonly accountsPrismaService: AccountsPrismaService) {}

  async create(createAccountDto: CreateAccountDto) {
    const { name, tenantId, displayName, ofTenancy, standing, grade } =
      createAccountDto;

    return this.accountsPrismaService.account.create({
      data: {
        name,
        tenantId,
        displayName,
        ofTenancy,
        standing,
        grade,
      },
    });
  }

  async findAll(tenantId: string) {
    return await this.accountsPrismaService.account.findMany({
      where: {
        tenantId: tenantId,
      },
    });
  }

  async findOne(accountId: string) {
    return await this.accountsPrismaService.account.findUnique({
      where: {
        id: accountId,
      },
    });
  }

  async update(accountId: string, updateAccountDto: UpdateAccountDto) {
    return await this.accountsPrismaService.account.update({
      where: {
        id: accountId,
      },
      data: updateAccountDto,
    });
  }

  async remove(accountId: string) {
    return await this.accountsPrismaService.account.delete({
      where: {
        id: accountId,
      },
    });
  }
}
