import type { Uuid } from './common';

export interface LocationSearchQuery {
  query: string;
  countryCode?: string;
  country?: string;
  limit?: number;
}

export interface SuburbLocation {
  id: Uuid;
  locality?: string;
  suburb: string;
  state: string;
  postcode: string;
  countryCode?: string;
  country: string;
  latitude?: number;
  longitude?: number;
}
