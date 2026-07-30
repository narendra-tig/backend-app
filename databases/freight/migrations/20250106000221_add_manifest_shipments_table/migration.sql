-- AlterTable
ALTER TABLE "Shipment" ADD COLUMN     "manifestId" UUID;

-- CreateTable
CREATE TABLE "ManifestShipment" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "manifestDate" TIMESTAMPTZ,
    "manifestReferenceId" TEXT,
    "carrierName" TEXT,
    "totalConsignment" INTEGER,
    "totalWeight" DECIMAL(65,30),
    "totalVolume" DECIMAL(65,30),
    "totalItems" INTEGER,
    "manifestPaperwork" TEXT,
    "accountId" UUID NOT NULL,
    "customerGroupId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ManifestShipment_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ManifestShipment_manifestReferenceId_key" ON "ManifestShipment"("manifestReferenceId");

-- AddForeignKey
ALTER TABLE "Shipment" ADD CONSTRAINT "Shipment_manifestId_fkey" FOREIGN KEY ("manifestId") REFERENCES "ManifestShipment"("id") ON DELETE SET NULL ON UPDATE CASCADE;
