import type { INestiaConfig } from '@nestia/sdk';

export const NESTIA_CONFIG: INestiaConfig = {
  input: 'src/**/*.controller.ts',
  output: './api',
  clone: true,
  distribute: 'packages/open360-api',
  e2e: 'test',
  swagger: {
    output: './swagger/swagger.json',
    beautify: true,
    openapi: '3.1',
    info: {
      title: 'Open360 Backend API',
      version: '1.0.0',
      description:
        'SDK-first modular API for tracking, shipments, returns, accounts, and tenancy.',
    },
    servers: [
      {
        url: process.env.API_BASE_URL ?? 'http://localhost:5000',
        description: process.env.ENV ?? 'local',
      },
    ],
  },
};

export default NESTIA_CONFIG;
