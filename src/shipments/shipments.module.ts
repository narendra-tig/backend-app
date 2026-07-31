import { Module } from '@nestjs/common';
import { FreightPrismaModule } from '../prisma/freight-prisma.module';
import { TenantAuthGuard } from '../common/tenant-auth.guard';
import { ShipmentsController } from './shipments.controller';
import { ShipmentsService } from './shipments.service';

@Module({
  imports: [FreightPrismaModule],
  controllers: [ShipmentsController],
  providers: [ShipmentsService, TenantAuthGuard],
  exports: [ShipmentsService],
})
export class ShipmentsModule {}
