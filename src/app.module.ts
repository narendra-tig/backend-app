import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AccountsModule } from './accounts/accounts.module';
import { FreightModule } from './freight/freight.module';
import { CoreModule } from './core/core.module';
import { DocumentsModule } from './documents/documents.module';
import { TrackingModule } from './tracking/tracking.module';

@Module({
  imports: [AccountsModule, FreightModule, CoreModule, DocumentsModule, TrackingModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
