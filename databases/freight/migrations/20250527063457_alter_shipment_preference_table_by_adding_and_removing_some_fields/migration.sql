/*
  Warnings:

  - You are about to drop the column `defaultSenderId` on the `ShipmentPreference` table. All the data in the column will be lost.
  - You are about to drop the column `defaultServiceName` on the `ShipmentPreference` table. All the data in the column will be lost.
  - You are about to drop the column `tenancyCarrierId` on the `ShipmentPreference` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "ServiceAlgorithmType" AS ENUM ('ALGORITHM', 'SERVICE');

-- DropIndex
DROP INDEX "ShipmentPreference_defaultSenderId_idx";

-- DropIndex
DROP INDEX "ShipmentPreference_tenancyCarrierId_idx";

-- AlterTable
ALTER TABLE "ShipmentPreference" DROP COLUMN "defaultSenderId",
DROP COLUMN "defaultServiceName",
DROP COLUMN "tenancyCarrierId",
ADD COLUMN     "defaultLocationId" UUID,
ADD COLUMN     "serviceAlgorithm" TEXT,
ADD COLUMN     "serviceAlgorithmType" "ServiceAlgorithmType" NOT NULL DEFAULT 'ALGORITHM';

-- CreateIndex
CREATE INDEX "ShipmentPreference_defaultLocationId_idx" ON "ShipmentPreference"("defaultLocationId");
