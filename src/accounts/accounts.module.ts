import { Module } from '@nestjs/common';
import { AccountsService } from './accounts.service';
import { AccountsController } from './accounts.controller';
import { AccountsPrismaModule } from '../prisma/accounts-prisma.module';
import { TenantAuthGuard } from '../common/tenant-auth.guard';

@Module({
  imports: [AccountsPrismaModule],
  controllers: [AccountsController],
  providers: [AccountsService, TenantAuthGuard],
  exports: [AccountsService],
})
export class AccountsModule {}
