import { Module } from '@nestjs/common';
import { AccountsService } from './accounts.service';
import { AccountsController } from './accounts.controller';
import { AccountsPrismaService } from '../prisma/accounts-prisma.service';

@Module({
  controllers: [AccountsController],
  providers: [AccountsService, AccountsPrismaService],
})
export class AccountsModule {}
