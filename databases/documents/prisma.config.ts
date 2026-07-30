import 'dotenv/config';
import { defineConfig } from 'prisma/config';

export default defineConfig({
  schema: '.',
  migrations: {
    path: './migrations',
  },
  datasource: {
    url: process.env.DOCUMENTS_DATABASE_URL,
  },
});
