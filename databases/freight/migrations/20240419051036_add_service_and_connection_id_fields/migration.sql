/*
  Warnings:

  - You are about to drop the column `supplier` on the `DraftShipment` table. All the data in the column will be lost.
  - You are about to drop the column `supplierService` on the `DraftShipment` table. All the data in the column will be lost.
  - You are about to drop the column `service` on the `Shipment` table. All the data in the column will be lost.
  - You are about to drop the column `carrierService` on the `ShipmentDetails` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "DraftShipment" DROP COLUMN "supplier",
DROP COLUMN "supplierService",
ADD COLUMN     "carrier" TEXT,
ADD COLUMN     "serviceName" TEXT;

-- AlterTable
ALTER TABLE "Shipment" DROP COLUMN "service",
ADD COLUMN     "connectionId" UUID NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000',
ADD COLUMN     "serviceId" UUID NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000',
ADD COLUMN     "serviceName" TEXT NOT NULL DEFAULT '';

-- AlterTable
ALTER TABLE "ShipmentDetails" DROP COLUMN "carrierService",
ADD COLUMN     "connectionId" UUID NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000',
ADD COLUMN     "serviceId" UUID NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000',
ADD COLUMN     "serviceName" TEXT NOT NULL DEFAULT '';
