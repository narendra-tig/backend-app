import { Module } from '@nestjs/common';
import { FreightPrismaModule } from '../prisma/freight-prisma.module';
import { TenantAuthGuard } from '../common/tenant-auth.guard';
import { LocationsController } from './locations.controller';
import { LocationsService } from './locations.service';

@Module({
  imports: [FreightPrismaModule],
  controllers: [LocationsController],
  providers: [LocationsService, TenantAuthGuard],
  exports: [LocationsService],
})
export class LocationsModule {}
