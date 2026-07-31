import { Module } from '@nestjs/common';
import { AccountsPrismaService } from './accounts-prisma.service';

@Module({
  providers: [AccountsPrismaService],
  exports: [AccountsPrismaService],
})
export class AccountsPrismaModule {}
