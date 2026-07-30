/*
  Warnings:

  - You are about to drop the column `carrierId` on the `ShipmentPreference` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "ShipmentPreference_carrierId_idx";

-- AlterTable
ALTER TABLE "ShipmentPreference" DROP COLUMN "carrierId",
ADD COLUMN     "customerGroupCarrierId" UUID,
ADD COLUMN     "tenancyCarrierId" UUID;

-- CreateIndex
CREATE INDEX "ShipmentPreference_customerGroupCarrierId_idx" ON "ShipmentPreference"("customerGroupCarrierId");

-- CreateIndex
CREATE INDEX "ShipmentPreference_tenancyCarrierId_idx" ON "ShipmentPreference"("tenancyCarrierId");
