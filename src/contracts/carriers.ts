import type { DateTimeString, Uuid } from './common';

export interface CarrierSummary {
  id: Uuid;
  name: string;
  displayName: string;
  status: string;
  previousStatus: string;
  notes?: string;
  refShortHand?: string;
  isActivated: boolean;
  createdAt: DateTimeString;
  updatedAt: DateTimeString;
}

export interface CarrierPackageType {
  id: Uuid;
  masterCarrierId: Uuid;
  carrierName: string;
  displayName: string;
  name: string;
  platformType: string;
  lengthMin?: number;
  lengthMax?: number;
  heightMin?: number;
  heightMax?: number;
  widthMin?: number;
  widthMax?: number;
  volumeMin?: number;
  volumeMax?: number;
  weightMin?: number;
  weightMax?: number;
  cubicMin?: number;
  cubicMax?: number;
}
