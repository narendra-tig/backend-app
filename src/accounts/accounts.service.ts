import { Injectable } from '@nestjs/common';
import { UpdateAccountDto } from './dto/update-account.dto';
import { AccountsPrismaService } from 'src/prisma/accounts-prisma.service';

@Injectable()
export class AccountsService {
  constructor(private readonly accountsPrismaService: AccountsPrismaService) {}

  // async create(createAccountDto: CreateAccountDto) {
  //   return await this.accountsPrismaService.account.create({
  //     data: createAccountDto,
  //   });
  // }

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
