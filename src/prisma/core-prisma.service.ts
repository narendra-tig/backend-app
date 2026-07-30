import { Injectable, OnModuleDestroy, OnModuleInit } from '@nestjs/common';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '../../models/core/client';

@Injectable()
export class CorePrismaService
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy
{
  constructor() {
    const connectionString = process.env.DATABASE_URL;

    if (!connectionString) {
      throw new Error('DATABASE_URL is not defined');
    }

    const isPrismaUrl = /^prisma(?:\+postgres)?:\/\//.test(connectionString);

    super(
      isPrismaUrl
        ? { accelerateUrl: connectionString }
        : { adapter: new PrismaPg({ connectionString }) },
    );
  }

  async onModuleInit() {
    await this.$connect();
  }

  async onModuleDestroy() {
    await this.$disconnect();
  }
}
