import type { INestiaConfig } from '@nestia/sdk';

export const NESTIA_CONFIG: INestiaConfig = {
  input: 'src/**/*.controller.ts',
  output: './api',
  clone: true,
  //   distribute: 'packages/open360-api',
  e2e: 'test',
};

export default NESTIA_CONFIG;
