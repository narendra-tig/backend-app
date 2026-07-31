import { Module } from '@nestjs/common';
import { FreightPrismaService } from './freight-prisma.service';

@Module({
  providers: [FreightPrismaService],
  exports: [FreightPrismaService],
})
export class FreightPrismaModule {}
