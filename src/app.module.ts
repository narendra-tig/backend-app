import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AccountsModule } from './accounts/accounts.module';
import { CarriersModule } from './carriers/carriers.module';
import { EnquiriesModule } from './enquiries/enquiries.module';
import { LocationsModule } from './locations/locations.module';
import { ReturnsModule } from './returns/returns.module';
import { ShipmentsModule } from './shipments/shipments.module';
import { TenancyModule } from './tenancy/tenancy.module';
import { TrackingFacadeModule } from './tracking-facade/tracking-facade.module';
import { TrackingModule } from './tracking/tracking.module';

@Module({
  imports: [
    AccountsModule,
    TenancyModule,
    ShipmentsModule,
    TrackingModule,
    ReturnsModule,
    CarriersModule,
    LocationsModule,
    EnquiriesModule,
    TrackingFacadeModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
