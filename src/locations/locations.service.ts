import { Injectable } from '@nestjs/common';
import type { LocationSearchQuery, SuburbLocation, Uuid } from '../contracts';
import { compact, toOptional } from '../common/json';
import { FreightPrismaService } from '../prisma/freight-prisma.service';

@Injectable()
export class LocationsService {
  constructor(private readonly freight: FreightPrismaService) {}

  async search(query: LocationSearchQuery): Promise<SuburbLocation[]> {
    const needle = query.query.trim();
    const countryCode = query.countryCode ?? query.country ?? 'AU';
    const limit = Math.min(Math.max(query.limit ?? 10, 1), 50);
    const rows = await this.freight.locations.findMany({
      where: {
        ...(countryCode
          ? { countryCode: { equals: countryCode, mode: 'insensitive' } }
          : {}),
        OR: [
          { suburb: { contains: needle, mode: 'insensitive' } },
          { postcode: { contains: needle, mode: 'insensitive' } },
          { locality: { contains: needle, mode: 'insensitive' } },
        ],
      },
      orderBy: [{ suburb: 'asc' }, { postcode: 'asc' }],
      take: limit,
    });
    return rows.map((row) =>
      compact({
        id: row.id as Uuid,
        locality: toOptional(row.locality),
        suburb: row.suburb,
        state: row.state,
        postcode: row.postcode,
        countryCode: toOptional(row.countryCode),
        country: row.country,
        latitude: toOptional(row.latitude),
        longitude: toOptional(row.longitude),
      }),
    );
  }
}
