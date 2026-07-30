/*
  Warnings:

  - A unique constraint covering the columns `[shipmentReferenceId]` on the table `DraftShipment` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "DraftShipment" ADD COLUMN     "shipmentReferenceId" TEXT;

-- CreateTable
CREATE TABLE "ShipmentReference" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "referenceId" TEXT NOT NULL,
    "shipmentId" UUID,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,

    CONSTRAINT "ShipmentReference_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentReference_referenceId_key" ON "ShipmentReference"("referenceId");

-- CreateIndex
CREATE UNIQUE INDEX "DraftShipment_shipmentReferenceId_key" ON "DraftShipment"("shipmentReferenceId");
