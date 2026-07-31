import { Injectable, NotFoundException } from '@nestjs/common';
import type {
  CarrierPackageType,
  CarrierSummary,
  DateTimeString,
  Uuid,
} from '../contracts';
import { compact, toOptional } from '../common/json';
import { FreightPrismaService } from '../prisma/freight-prisma.service';

@Injectable()
export class CarriersService {
  constructor(private readonly freight: FreightPrismaService) {}

  async findByName(name: string): Promise<CarrierSummary> {
    const row = await this.freight.masterCarrier.findUnique({
      where: { name },
    });
    if (!row) throw new NotFoundException('Carrier not found');
    return compact({
      id: row.id as Uuid,
      name: row.name,
      displayName: row.displayName,
      status: row.status,
      previousStatus: row.previousStatus,
      notes: toOptional(row.notes),
      refShortHand: toOptional(row.refShortHand),
      isActivated: row.isActivated,
      createdAt: row.createdAt.toISOString() as DateTimeString,
      updatedAt: row.updatedAt.toISOString() as DateTimeString,
    });
  }

  async getPackageTypes(): Promise<CarrierPackageType[]> {
    const rows = await this.freight.masterCarrierPackageType.findMany({
      include: { masterCarrier: true },
      orderBy: [
        { masterCarrier: { displayName: 'asc' } },
        { displayName: 'asc' },
      ],
    });
    return rows.map((row) =>
      compact({
        id: row.id as Uuid,
        masterCarrierId: row.masterCarrierId as Uuid,
        carrierName: row.masterCarrier.name,
        displayName: row.displayName,
        name: row.name,
        platformType: row.platformType,
        lengthMin: toOptional(row.lengthMin),
        lengthMax: toOptional(row.lengthMax),
        heightMin: toOptional(row.heightMin),
        heightMax: toOptional(row.heightMax),
        widthMin: toOptional(row.widthMin),
        widthMax: toOptional(row.widthMax),
        volumeMin: toOptional(row.volumeMin),
        volumeMax: toOptional(row.volumeMax),
        weightMin: toOptional(row.weightMin),
        weightMax: toOptional(row.weightMax),
        cubicMin: toOptional(row.cubicMin),
        cubicMax: toOptional(row.cubicMax),
      }),
    );
  }
}
