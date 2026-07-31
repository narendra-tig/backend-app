import { Module } from '@nestjs/common';
import { AccountsPrismaModule } from '../prisma/accounts-prisma.module';
import { ShipmentsModule } from '../shipments/shipments.module';
import { EnquiriesController } from './enquiries.controller';
import { HelpDeskClient } from './help-desk.client';
import { EnquiriesService } from './enquiries.service';

@Module({
  imports: [AccountsPrismaModule, ShipmentsModule],
  controllers: [EnquiriesController],
  providers: [EnquiriesService, HelpDeskClient],
})
export class EnquiriesModule {}
