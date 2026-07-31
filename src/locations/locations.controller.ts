import { Controller, UseGuards } from '@nestjs/common';
import { TypedHeaders, TypedQuery, TypedRoute } from '@nestia/core';
import type {
  LocationSearchQuery,
  SuburbLocation,
  TenantHeaders,
} from '../contracts';
import { TenantAuthGuard } from '../common/tenant-auth.guard';
import { LocationsService } from './locations.service';

@Controller('v1/locations')
export class LocationsController {
  constructor(private readonly locations: LocationsService) {}

  @TypedRoute.Get('search')
  @UseGuards(TenantAuthGuard)
  search(
    @TypedHeaders() _headers: TenantHeaders,
    @TypedQuery() query: LocationSearchQuery,
  ): Promise<SuburbLocation[]> {
    return this.locations.search(query);
  }
}
