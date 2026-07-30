-- CreateTable
CREATE TABLE "ShipmentPrintingPresets" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "presetName" TEXT NOT NULL,
    "tenantId" UUID NOT NULL,
    "customerGroupId" UUID NOT NULL,
    "documentSelections" JSONB[],
    "printFormat" TEXT NOT NULL,
    "printerType" TEXT NOT NULL,
    "printOrder1" TEXT,
    "printOrder2" TEXT,
    "printOrder3" TEXT,
    "printOrder4" TEXT,
    "printOrder5" TEXT,
    "printOrder6" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ShipmentPrintingPresets_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentPrintingPresets_customerGroupId_presetName_key" ON "ShipmentPrintingPresets"("customerGroupId", "presetName");

-- AddForeignKey
ALTER TABLE "ShipmentPrintingPresets" ADD CONSTRAINT "ShipmentPrintingPresets_customerGroupId_fkey" FOREIGN KEY ("customerGroupId") REFERENCES "CustomerGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;
