-- AlterTable
ALTER TABLE "ManifestShipment" ADD COLUMN     "serviceName" TEXT;

-- AlterTable
ALTER TABLE "Pickup" ADD COLUMN     "receiverName" TEXT,
ADD COLUMN     "senderName" TEXT;

-- CreateIndex
CREATE INDEX "ManifestShipment_serviceName_idx" ON "ManifestShipment"("serviceName");

-- CreateIndex
CREATE INDEX "ManifestShipment_carrierName_idx" ON "ManifestShipment"("carrierName");

-- CreateIndex
CREATE INDEX "Pickup_senderName_idx" ON "Pickup"("senderName");

-- CreateIndex
CREATE INDEX "Pickup_receiverName_idx" ON "Pickup"("receiverName");
