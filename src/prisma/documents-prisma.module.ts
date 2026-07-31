import { Module } from '@nestjs/common';
import { DocumentsPrismaService } from './documents-prisma.service';

@Module({
  providers: [DocumentsPrismaService],
  exports: [DocumentsPrismaService],
})
export class DocumentsPrismaModule {}
