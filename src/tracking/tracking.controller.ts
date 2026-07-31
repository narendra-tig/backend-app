import { Controller, UseGuards } from '@nestjs/common';
import {
  TypedBody,
  TypedHeaders,
  TypedParam,
  TypedQuery,
  TypedRoute,
} from '@nestia/core';
import { tenantIdFrom } from '../common/tenant';
import { InternalApiGuard } from '../common/internal-api.guard';
import type {
  OkResponse,
  InternalHeaders,
  RegisterTrackingShipmentRequest,
  SaveNotifiedEventRequest,
  SaveTrackingEventsRequest,
  TenantInternalHeaders,
  TrackingEventsResponse,
  TrackingShipment,
  TrackingShipmentsResponse,
  UpdateDeliveredShipmentRequest,
  Uuid,
} from '../contracts';
import { TrackingService } from './tracking.service';

interface PollTrackingQuery {
  limit?: number;
}

@Controller('v1/tracking-service')
@UseGuards(InternalApiGuard)
export class TrackingController {
  constructor(private readonly tracking: TrackingService) {}

  @TypedRoute.Get('shipments/:shipmentId/events')
  getTrackingEvents(
    @TypedHeaders() headers: TenantInternalHeaders,
    @TypedParam('shipmentId') shipmentId: Uuid,
  ): Promise<TrackingEventsResponse> {
    return this.tracking.getTrackingEvents(tenantIdFrom(headers), shipmentId);
  }

  @TypedRoute.Post('events')
  async saveTrackingEvents(
    @TypedHeaders() _headers: InternalHeaders,
    @TypedBody() input: SaveTrackingEventsRequest,
  ): Promise<OkResponse> {
    await this.tracking.saveTrackingEvents(input);
    return { ok: true };
  }

  @TypedRoute.Get('accounts/:accountId/shipments')
  getShipmentsTracking(
    @TypedHeaders() headers: TenantInternalHeaders,
    @TypedParam('accountId') accountId: Uuid,
  ): Promise<TrackingShipmentsResponse> {
    return this.tracking.getShipmentsTracking(tenantIdFrom(headers), accountId);
  }

  @TypedRoute.Get('poll')
  getShipmentsForTracking(
    @TypedHeaders() _headers: InternalHeaders,
    @TypedQuery() query: PollTrackingQuery,
  ): Promise<TrackingShipmentsResponse> {
    return this.tracking.getShipmentsForTracking(query.limit);
  }

  @TypedRoute.Patch('shipments/:shipmentId/delivery')
  async updateDeliveredShipment(
    @TypedHeaders() headers: TenantInternalHeaders,
    @TypedParam('shipmentId') shipmentId: Uuid,
    @TypedBody() input: UpdateDeliveredShipmentRequest,
  ): Promise<OkResponse> {
    await this.tracking.updateDeliveredShipment(
      tenantIdFrom(headers),
      shipmentId,
      input,
    );
    return { ok: true };
  }

  @TypedRoute.Put('shipments/:shipmentId')
  registerTrackingShipment(
    @TypedHeaders() headers: TenantInternalHeaders,
    @TypedParam('shipmentId') shipmentId: Uuid,
    @TypedBody() input: RegisterTrackingShipmentRequest,
  ): Promise<TrackingShipment> {
    return this.tracking.registerTrackingShipment(
      tenantIdFrom(headers),
      shipmentId,
      input,
    );
  }

  @TypedRoute.Get('shipments/:shipmentId')
  getShipmentTracking(
    @TypedHeaders() headers: TenantInternalHeaders,
    @TypedParam('shipmentId') shipmentId: Uuid,
  ): Promise<TrackingShipment> {
    return this.tracking.getShipmentTracking(tenantIdFrom(headers), shipmentId);
  }

  @TypedRoute.Post('shipments/:shipmentId/notified-events')
  async saveNotifiedEvent(
    @TypedHeaders() headers: TenantInternalHeaders,
    @TypedParam('shipmentId') shipmentId: Uuid,
    @TypedBody() input: SaveNotifiedEventRequest,
  ): Promise<OkResponse> {
    await this.tracking.saveNotifiedEvent(
      tenantIdFrom(headers),
      shipmentId,
      input,
    );
    return { ok: true };
  }
}
