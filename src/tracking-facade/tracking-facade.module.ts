import { Module } from '@nestjs/common';
import { AccountsModule } from '../accounts/accounts.module';
import { CarriersModule } from '../carriers/carriers.module';
import { ShipmentsModule } from '../shipments/shipments.module';
import { TrackingModule } from '../tracking/tracking.module';
import { TrackingFacadeController } from './tracking-facade.controller';
import { TrackingFacadeService } from './tracking-facade.service';
import { TenantAuthGuard } from '../common/tenant-auth.guard';

@Module({
  imports: [AccountsModule, CarriersModule, ShipmentsModule, TrackingModule],
  controllers: [TrackingFacadeController],
  providers: [TrackingFacadeService, TenantAuthGuard],
})
export class TrackingFacadeModule {}
