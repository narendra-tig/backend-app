import { Module } from '@nestjs/common';
import { TrackingPrismaService } from './tracking-prisma.service';

@Module({
  providers: [TrackingPrismaService],
  exports: [TrackingPrismaService],
})
export class TrackingPrismaModule {}
