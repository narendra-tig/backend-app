import { Module } from '@nestjs/common';
import { FreightPrismaModule } from '../prisma/freight-prisma.module';
import { TrackingPrismaModule } from '../prisma/tracking-prisma.module';
import { InternalApiGuard } from '../common/internal-api.guard';
import { TrackingController } from './tracking.controller';
import { TrackingService } from './tracking.service';

@Module({
  imports: [FreightPrismaModule, TrackingPrismaModule],
  controllers: [TrackingController],
  providers: [TrackingService, InternalApiGuard],
  exports: [TrackingService],
})
export class TrackingModule {}
