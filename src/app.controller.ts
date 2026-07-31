import { Controller } from '@nestjs/common';
import { TypedRoute } from '@nestia/core';
import type { HealthResponse } from './contracts';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @TypedRoute.Get()
  health(): HealthResponse {
    return this.appService.health();
  }
}
