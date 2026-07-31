import { Controller } from '@nestjs/common';
import { TypedParam, TypedRoute } from '@nestia/core';
import type { CarrierPackageType, CarrierSummary } from '../contracts';
import { CarriersService } from './carriers.service';

@Controller('v1/carriers')
export class CarriersController {
  constructor(private readonly carriers: CarriersService) {}

  @TypedRoute.Get('package-types')
  getPackageTypes(): Promise<CarrierPackageType[]> {
    return this.carriers.getPackageTypes();
  }

  @TypedRoute.Get('by-name/:name')
  findByName(@TypedParam('name') name: string): Promise<CarrierSummary> {
    return this.carriers.findByName(name);
  }
}
