import { Module } from '@nestjs/common';
import { AccountsPrismaModule } from '../prisma/accounts-prisma.module';
import { CorePrismaModule } from '../prisma/core-prisma.module';
import { TenantAuthGuard } from '../common/tenant-auth.guard';
import { TenancyController } from './tenancy.controller';
import { TenancyService } from './tenancy.service';

@Module({
  imports: [AccountsPrismaModule, CorePrismaModule],
  controllers: [TenancyController],
  providers: [TenancyService, TenantAuthGuard],
  exports: [TenancyService],
})
export class TenancyModule {}
