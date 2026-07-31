import { Controller, UseGuards } from '@nestjs/common';
import { TypedHeaders, TypedParam, TypedQuery, TypedRoute } from '@nestia/core';
import { tenantIdFrom } from '../common/tenant';
import { TenantAuthGuard } from '../common/tenant-auth.guard';
import type {
  ShipmentListQuery,
  ShipmentListResponse,
  ShipmentResponse,
  TenantHeaders,
  Uuid,
} from '../contracts';
import { ShipmentsService } from './shipments.service';

@Controller('v1/shipments')
export class ShipmentsController {
  constructor(private readonly shipments: ShipmentsService) {}

  @TypedRoute.Get()
  @UseGuards(TenantAuthGuard)
  list(
    @TypedHeaders() headers: TenantHeaders,
    @TypedQuery() query: ShipmentListQuery,
  ): Promise<ShipmentListResponse> {
    return this.shipments.list(tenantIdFrom(headers), query);
  }

  @TypedRoute.Get('by-reference/:shipmentReference')
  findByReference(
    @TypedParam('shipmentReference') shipmentReference: string,
  ): Promise<ShipmentResponse> {
    return this.shipments.findByReference(shipmentReference);
  }

  @TypedRoute.Get(':shipmentId')
  @UseGuards(TenantAuthGuard)
  findById(
    @TypedHeaders() headers: TenantHeaders,
    @TypedParam('shipmentId') shipmentId: Uuid,
  ): Promise<ShipmentResponse> {
    return this.shipments.findById(tenantIdFrom(headers), shipmentId);
  }
}
