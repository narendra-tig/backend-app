-- AlterTable
ALTER TABLE "DraftShipment" ADD COLUMN     "eta" TEXT DEFAULT '';

-- AlterTable
ALTER TABLE "Shipment" ADD COLUMN     "consignmentReference" TEXT,
ADD COLUMN     "internalReference" TEXT;

-- AlterTable
ALTER TABLE "ShipmentDetails" ADD COLUMN     "consignmentReference" TEXT,
ADD COLUMN     "eta" TEXT DEFAULT '',
ADD COLUMN     "internalReference" TEXT;
