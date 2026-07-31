import { Module } from '@nestjs/common';
import { FreightPrismaModule } from '../prisma/freight-prisma.module';
import { CarriersController } from './carriers.controller';
import { CarriersService } from './carriers.service';

@Module({
  imports: [FreightPrismaModule],
  controllers: [CarriersController],
  providers: [CarriersService],
  exports: [CarriersService],
})
export class CarriersModule {}
