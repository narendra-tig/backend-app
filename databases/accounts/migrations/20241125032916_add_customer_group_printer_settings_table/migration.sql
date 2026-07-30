-- CreateEnum
CREATE TYPE "CustomerGroupPrinterType" AS ENUM ('CG_THERMAL', 'CG_CLOUD', 'CG_PDF');

-- CreateTable
CREATE TABLE "PrinterSetting" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "customerGroupId" UUID NOT NULL,
    "type" "CustomerGroupPrinterType" NOT NULL,
    "printerId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "margin" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "PrinterSetting_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PrinterSetting_customerGroupId_key" ON "PrinterSetting"("customerGroupId");

-- AddForeignKey
ALTER TABLE "PrinterSetting" ADD CONSTRAINT "PrinterSetting_customerGroupId_fkey" FOREIGN KEY ("customerGroupId") REFERENCES "CustomerGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;
