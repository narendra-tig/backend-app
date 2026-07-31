import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from './../src/app.module';
import cookieParser from 'cookie-parser';
import { AccountsPrismaService } from '../src/prisma/accounts-prisma.service';
import { CorePrismaService } from '../src/prisma/core-prisma.service';
import { FreightPrismaService } from '../src/prisma/freight-prisma.service';
import { TrackingPrismaService } from '../src/prisma/tracking-prisma.service';

describe('AppController (e2e)', () => {
  let app: INestApplication<App>;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    })
      .overrideProvider(AccountsPrismaService)
      .useValue({})
      .overrideProvider(CorePrismaService)
      .useValue({})
      .overrideProvider(FreightPrismaService)
      .useValue({})
      .overrideProvider(TrackingPrismaService)
      .useValue({})
      .compile();

    app = moduleFixture.createNestApplication();
    app.use(cookieParser());
    await app.init();
  });

  it('/ (GET)', () => {
    return request(app.getHttpServer())
      .get('/')
      .expect(200)
      .expect((response) => {
        const body = response.body as {
          status?: unknown;
          service?: unknown;
          timestamp?: unknown;
        };
        expect(body).toMatchObject({
          status: 'ok',
          service: 'backend-app',
        });
        expect(typeof body.timestamp).toBe('string');
      });
  });

  afterEach(async () => {
    await app.close();
  });
});
