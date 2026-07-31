import { Module } from '@nestjs/common';
import { FreightPrismaModule } from '../prisma/freight-prisma.module';
import { AccountsModule } from '../accounts/accounts.module';
import { CarriersModule } from '../carriers/carriers.module';
import { ShipmentsModule } from '../shipments/shipments.module';
import { TrackingModule } from '../tracking/tracking.module';
import { ReturnsController } from './returns.controller';
import { ReturnsService } from './returns.service';

@Module({
  imports: [
    FreightPrismaModule,
    AccountsModule,
    CarriersModule,
    ShipmentsModule,
    TrackingModule,
  ],
  controllers: [ReturnsController],
  providers: [ReturnsService],
  exports: [ReturnsService],
})
export class ReturnsModule {}
