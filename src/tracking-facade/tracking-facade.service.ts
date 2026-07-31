import { Injectable } from '@nestjs/common';
import type { Branding, TrackingFacadeResponse, Uuid } from '../contracts';
import { AccountsService } from '../accounts/accounts.service';
import { CarriersService } from '../carriers/carriers.service';
import { ShipmentsService } from '../shipments/shipments.service';
import { TrackingService } from '../tracking/tracking.service';

const DEFAULT_BRANDING: Branding = {
  logo: 'https://storage.googleapis.com/tig-freight-bucket/public/logo/alm%20logo.jpg.jpeg',
  logoLink: 'https://www.allmar.com.au/',
  logoPosition: 'top-right',
  background:
    'https://storage.googleapis.com/tig-freight-bucket/public/background/117334022_2539813489662176_4213495371253910930_o.jpg.jpeg',
  heading: 'Carrier Shipment Tracking',
  theme: 'light',
};

@Injectable()
export class TrackingFacadeService {
  constructor(
    private readonly shipments: ShipmentsService,
    private readonly tracking: TrackingService,
    private readonly accounts: AccountsService,
    private readonly carriers: CarriersService,
  ) {}

  async findByReference(reference: string): Promise<TrackingFacadeResponse> {
    const shipment = await this.shipments.findByReference(reference);
    const [tracking, account, supplier] = await Promise.all([
      this.tracking.getTrackingEvents(shipment.tenantId, shipment.id),
      this.accounts.findOne(shipment.tenantId, shipment.accountId),
      this.carriers.findByName(shipment.carrier),
    ]);
    return {
      shipment,
      tracking: tracking.trackingEvents,
      account,
      supplier,
      branding: DEFAULT_BRANDING,
    };
  }

  async getEvents(
    tenantId: Uuid,
    shipmentId: Uuid,
  ): Promise<TrackingFacadeResponse['tracking']> {
    return (await this.tracking.getTrackingEvents(tenantId, shipmentId))
      .trackingEvents;
  }
}
