import 'dotenv/config';
import { defineConfig } from 'prisma/config';

export default defineConfig({
  schema: '.',
  migrations: {
    path: './migrations',
  },
  datasource: {
    url: process.env.FREIGHT_DATABASE_URL,
  },
});
