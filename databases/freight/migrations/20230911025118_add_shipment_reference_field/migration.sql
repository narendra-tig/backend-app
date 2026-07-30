/*
  Warnings:

  - A unique constraint covering the columns `[shipmentReferenceId]` on the table `Shipment` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Shipment" ADD COLUMN     "estimatedPrice" TEXT,
ADD COLUMN     "shipmentReferenceId" TEXT,
ALTER COLUMN "reference" DROP NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Shipment_shipmentReferenceId_key" ON "Shipment"("shipmentReferenceId");
