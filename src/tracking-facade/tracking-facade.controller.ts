import { Controller, UseGuards } from '@nestjs/common';
import { TypedHeaders, TypedParam, TypedRoute } from '@nestia/core';
import { tenantIdFrom } from '../common/tenant';
import { TenantAuthGuard } from '../common/tenant-auth.guard';
import type {
  TenantHeaders,
  TrackingEventResponse,
  TrackingFacadeResponse,
  Uuid,
} from '../contracts';
import { TrackingFacadeService } from './tracking-facade.service';

@Controller('v1/tracking/shipments')
export class TrackingFacadeController {
  constructor(private readonly facade: TrackingFacadeService) {}

  @TypedRoute.Get('by-reference/:shipmentReference')
  findByReference(
    @TypedParam('shipmentReference') shipmentReference: string,
  ): Promise<TrackingFacadeResponse> {
    return this.facade.findByReference(shipmentReference);
  }

  @TypedRoute.Get(':shipmentId/events')
  @UseGuards(TenantAuthGuard)
  getEvents(
    @TypedHeaders() headers: TenantHeaders,
    @TypedParam('shipmentId') shipmentId: Uuid,
  ): Promise<TrackingEventResponse[]> {
    return this.facade.getEvents(tenantIdFrom(headers), shipmentId);
  }
}
