-- CreateTable
CREATE TABLE "CustomerGroupServicePrintingPreference" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "customerGroupId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "carrierId" UUID NOT NULL,
    "carrierName" TEXT NOT NULL,
    "serviceId" UUID NOT NULL,
    "serviceCode" TEXT,
    "serviceName" TEXT,
    "recordName" TEXT,
    "labelPrinterId" TEXT,
    "labelPrinterName" TEXT,
    "labels" INTEGER NOT NULL DEFAULT 1,
    "specialInstructions" TEXT,
    "cubic" DOUBLE PRECISION,
    "rangeLeft" DOUBLE PRECISION,
    "notes" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CustomerGroupServicePrintingPreference_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CustomerGroupServicePrintingPreference_customerGroupId_serv_key" ON "CustomerGroupServicePrintingPreference"("customerGroupId", "serviceId");

-- AddForeignKey
ALTER TABLE "CustomerGroupServicePrintingPreference" ADD CONSTRAINT "CustomerGroupServicePrintingPreference_customerGroupId_fkey" FOREIGN KEY ("customerGroupId") REFERENCES "CustomerGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;
