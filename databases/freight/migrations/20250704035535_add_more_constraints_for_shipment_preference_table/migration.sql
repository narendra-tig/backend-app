/*
  Warnings:

  - A unique constraint covering the columns `[customerGroupId]` on the table `ShipmentPreference` will be added. If there are existing duplicate values, this will fail.
  - Made the column `customerGroupId` on table `ShipmentPreference` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "ShipmentPreference" ALTER COLUMN "customerGroupId" SET NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentPreference_customerGroupId_key" ON "ShipmentPreference"("customerGroupId");
