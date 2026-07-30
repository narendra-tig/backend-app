import { Module } from '@nestjs/common';
import { AccountsService } from './accounts.service';
import { AccountsController } from './accounts.controller';
import { ListModule } from './list/list.module';

@Module({
  controllers: [AccountsController],
  providers: [AccountsService],
  imports: [ListModule],
})
export class AccountsModule {}
