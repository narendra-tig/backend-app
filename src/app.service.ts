import { Injectable } from '@nestjs/common';
import type { DateTimeString, HealthResponse } from './contracts';

@Injectable()
export class AppService {
  health(): HealthResponse {
    return {
      status: 'ok',
      service: 'backend-app',
      timestamp: new Date().toISOString() as DateTimeString,
    };
  }
}
