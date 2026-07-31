import { Injectable, NotFoundException } from '@nestjs/common';
import { createHash } from 'node:crypto';
import type {
  DateTimeString,
  PersistTrackingEvent,
  RegisterTrackingShipmentRequest,
  SaveNotifiedEventRequest,
  SaveTrackingEventsRequest,
  TrackingEventResponse,
  TrackingEventsResponse,
  TrackingShipment,
  TrackingShipmentsResponse,
  UpdateDeliveredShipmentRequest,
  Uuid,
} from '../contracts';
import { compact, toJsonValue, toOptional } from '../common/json';
import { FreightPrismaService } from '../prisma/freight-prisma.service';
import { TrackingPrismaService } from '../prisma/tracking-prisma.service';
import type {
  Shipment as TrackingShipmentRow,
  TrackingEvent as TrackingEventRow,
} from '../../models/tracking/client';

@Injectable()
export class TrackingService {
  constructor(
    private readonly tracking: TrackingPrismaService,
    private readonly freight: FreightPrismaService,
  ) {}

  async getTrackingEvents(
    tenantId: Uuid,
    shipmentId: Uuid,
  ): Promise<TrackingEventsResponse> {
    const rows = await this.tracking.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
      return tx.trackingEvent.findMany({
        where: { tenantId, shipmentId },
        orderBy: { createdAt: 'desc' },
      });
    });
    const taxonomy = await this.getTaxonomy(
      rows.map((row) => row.trackingEventId),
    );
    return {
      trackingEvents: rows.map((row) => this.toEvent(row, taxonomy)),
    };
  }

  async saveTrackingEvents(input: SaveTrackingEventsRequest): Promise<void> {
    await Promise.all(
      input.shipments.map((shipment) =>
        this.tracking.$transaction(async (tx) => {
          await tx.$executeRaw`SELECT set_config('app.tenant_id', ${input.tenantId}, TRUE)`;
          const existing = await tx.shipment.findFirst({
            where: {
              shipmentId: shipment.shipmentId,
              tenantId: input.tenantId,
            },
          });
          if (!existing) {
            await tx.shipment.create({
              data: {
                shipmentId: shipment.shipmentId,
                carrier: input.carrier ?? shipment.carrier,
                consignmentId: shipment.consignmentId,
                isDelivered: shipment.delivered,
                notifiedEvents: shipment.notifiedEvents,
                connectionId: shipment.connectionId,
                accountId: shipment.accountId,
                tenantId: input.tenantId,
                data: (shipment.data ?? undefined) as never,
              },
            });
          } else {
            await tx.shipment.update({
              where: { shipmentId: shipment.shipmentId },
              data: {
                carrier: input.carrier ?? shipment.carrier ?? existing.carrier,
                consignmentId: shipment.consignmentId ?? existing.consignmentId,
                isDelivered: shipment.delivered,
                connectionId: shipment.connectionId,
                accountId: shipment.accountId,
                data: (shipment.data ?? existing.data ?? undefined) as never,
              },
            });
          }
          if (input.trackingBehavior === 'OVERRIDE') {
            await tx.trackingEvent.deleteMany({
              where: {
                shipmentId: shipment.shipmentId,
                tenantId: input.tenantId,
              },
            });
          }
          if (shipment.events.length) {
            await tx.trackingEvent.createMany({
              data: shipment.events.map((event) => {
                const createdAt = new Date(event.timestamp);
                return {
                  shipmentId: shipment.shipmentId,
                  tenantId: input.tenantId,
                  location: event.location,
                  packageRef: event.packageRef,
                  consignment: event.consignmentId,
                  trackingEventId: event.trackingEventId,
                  replayKey: this.replayKey(event),
                  createdAt,
                };
              }),
              skipDuplicates: true,
            });
          }
        }),
      ),
    );
    if (input.trackingBehavior === 'OVERRIDE') {
      await this.publishTrackingNotifications(input);
    }
  }

  async getShipmentsTracking(
    tenantId: Uuid,
    accountId: Uuid,
  ): Promise<TrackingShipmentsResponse> {
    const rows = await this.tracking.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
      return tx.shipment.findMany({
        where: { tenantId, accountId },
        include: { trackingEvents: { orderBy: { createdAt: 'desc' } } },
        orderBy: { createdAt: 'desc' },
      });
    });
    return { shipments: rows.map((row) => this.toTrackingShipment(row)) };
  }

  async getShipmentsForTracking(
    limit = 10,
  ): Promise<TrackingShipmentsResponse> {
    const rows = await this.tracking.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.bypass_rls', 'on', TRUE)`;
      return tx.shipment.findMany({
        where: { isDelivered: false },
        include: { trackingEvents: { orderBy: { createdAt: 'desc' } } },
        take: Math.min(Math.max(limit, 1), 100),
        orderBy: { createdAt: 'asc' },
      });
    });
    return { shipments: rows.map((row) => this.toTrackingShipment(row)) };
  }

  async updateDeliveredShipment(
    tenantId: Uuid,
    shipmentId: Uuid,
    input: UpdateDeliveredShipmentRequest,
  ): Promise<void> {
    await this.assertShipment(tenantId, shipmentId);
    await this.tracking.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
      await tx.shipment.update({
        where: { shipmentId },
        data: { isDelivered: input.delivered },
      });
    });
  }

  async registerTrackingShipment(
    tenantId: Uuid,
    shipmentId: Uuid,
    input: RegisterTrackingShipmentRequest,
  ): Promise<TrackingShipment> {
    const row = await this.tracking.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
      return tx.shipment.upsert({
        where: { shipmentId },
        create: {
          shipmentId,
          tenantId,
          accountId: input.accountId,
          connectionId: input.connectionId,
          consignmentId: input.consignmentId,
          carrier: input.carrier,
          data: input.data as never,
          isDelivered: false,
          notifiedEvents: [],
        },
        update: {
          accountId: input.accountId,
          connectionId: input.connectionId,
          consignmentId: input.consignmentId,
          carrier: input.carrier,
          data: input.data as never,
        },
        include: { trackingEvents: true },
      });
    });
    return this.toTrackingShipment(row);
  }

  async getShipmentTracking(
    tenantId: Uuid,
    shipmentId: Uuid,
  ): Promise<TrackingShipment> {
    const row = await this.tracking.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
      return tx.shipment.findFirst({
        where: { shipmentId, tenantId },
        include: { trackingEvents: { orderBy: { createdAt: 'desc' } } },
      });
    });
    if (!row) throw new NotFoundException('Tracking shipment not found');
    return this.toTrackingShipment(row);
  }

  async saveNotifiedEvent(
    tenantId: Uuid,
    shipmentId: Uuid,
    input: SaveNotifiedEventRequest,
  ): Promise<void> {
    const shipment = await this.assertShipment(tenantId, shipmentId);
    const notifiedEvents = Array.from(
      new Set([...shipment.notifiedEvents, input.status]),
    );
    await this.tracking.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
      await tx.shipment.update({
        where: { shipmentId },
        data: compact({
          notifiedEvents,
          isDelivered: input.isDelivered,
        }),
      });
    });
  }

  private async assertShipment(
    tenantId: Uuid,
    shipmentId: Uuid,
  ): Promise<TrackingShipmentRow> {
    const row = await this.tracking.$transaction(async (tx) => {
      await tx.$executeRaw`SELECT set_config('app.tenant_id', ${tenantId}, TRUE)`;
      return tx.shipment.findFirst({ where: { shipmentId, tenantId } });
    });
    if (!row) throw new NotFoundException('Tracking shipment not found');
    return row;
  }

  private async getTaxonomy(ids: string[]) {
    if (!ids.length) return new Map<string, Taxonomy>();
    const rows = await this.freight.carrierTrackingEvent.findMany({
      where: { id: { in: Array.from(new Set(ids)) } },
      include: { platformTrackingEvent: true },
    });
    return new Map<string, Taxonomy>(
      rows.map((row) => [
        row.id,
        {
          carrier: row.carrier,
          level0: {
            id: row.id as Uuid,
            name: row.name,
            description: row.name,
          },
          level1: {
            id: row.platformTrackingEvent.id as Uuid,
            name: row.platformTrackingEvent.name,
            description: row.platformTrackingEvent.displayName,
          },
        },
      ]),
    );
  }

  private async publishTrackingNotifications(
    input: SaveTrackingEventsRequest,
  ): Promise<void> {
    const url = process.env.NOTIFICATIONS_TRACKING_URL;
    if (!url) return;
    const ids = input.shipments.flatMap((shipment) =>
      shipment.events.map((event) => event.trackingEventId),
    );
    const taxonomy = await this.getTaxonomy(ids);
    const statuses = new Set([
      'MANIFESTED',
      'ONBOARD_FOR_DELIVERY',
      'DELIVERED',
    ]);
    await Promise.all(
      input.shipments.flatMap((shipment) =>
        shipment.events.flatMap((event) => {
          const status = taxonomy.get(event.trackingEventId)?.level1.name;
          if (!status || !statuses.has(status)) return [];
          const data = Buffer.from(
            JSON.stringify({
              tenantId: input.tenantId,
              shipmentId: shipment.shipmentId,
              status,
            }),
          ).toString('base64');
          return fetch(url, {
            method: 'POST',
            headers: { 'content-type': 'application/json' },
            body: JSON.stringify({ message: { data } }),
          }).then((response) => {
            if (!response.ok) {
              throw new Error(
                `Notifications service rejected tracking event (${response.status})`,
              );
            }
          });
        }),
      ),
    );
  }

  private replayKey(event: PersistTrackingEvent): string {
    return createHash('sha256')
      .update(
        [
          event.tenantId,
          event.shipmentId,
          event.trackingEventId,
          event.timestamp,
          event.location,
          event.packageRef ?? '',
          event.consignmentId ?? '',
        ].join('\u0000'),
      )
      .digest('hex');
  }

  private toEvent(
    row: TrackingEventRow,
    taxonomy: Map<string, Taxonomy>,
  ): TrackingEventResponse {
    const detail = taxonomy.get(row.trackingEventId);
    return compact({
      shipmentId: row.shipmentId as Uuid,
      tenantId: row.tenantId as Uuid,
      carrier: detail?.carrier ?? '',
      timestamp: row.createdAt.toISOString() as DateTimeString,
      location: row.location,
      packageRef: toOptional(row.packageRef),
      level0: detail?.level0 ?? {
        id: row.trackingEventId as Uuid,
        name: row.trackingEventId,
        description: row.trackingEventId,
      },
      level1: detail?.level1,
    });
  }

  private toTrackingShipment(
    row: TrackingShipmentRow & { trackingEvents?: TrackingEventRow[] },
  ): TrackingShipment {
    return compact({
      shipmentId: row.shipmentId as Uuid,
      delivered: row.isDelivered,
      events: (row.trackingEvents ?? []).map((event): PersistTrackingEvent =>
        compact({
          shipmentId: row.shipmentId as Uuid,
          tenantId: event.tenantId as Uuid,
          timestamp: event.createdAt.toISOString() as DateTimeString,
          location: event.location,
          packageRef: toOptional(event.packageRef),
          trackingEventId: event.trackingEventId as Uuid,
          connectionId: row.connectionId as Uuid,
          consignmentId: toOptional(event.consignment),
        }),
      ),
      connectionId: row.connectionId as Uuid,
      consignmentId: toOptional(row.consignmentId),
      tenantId: row.tenantId as Uuid,
      notifiedEvents: row.notifiedEvents,
      data: toJsonValue(row.data),
      accountId: row.accountId as Uuid,
      carrier: toOptional(row.carrier),
    });
  }
}

interface Taxonomy {
  carrier: string;
  level0: { id: Uuid; name: string; description: string };
  level1: { id: Uuid; name: string; description: string };
}
