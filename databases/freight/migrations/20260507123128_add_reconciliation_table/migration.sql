-- CreateEnum
CREATE TYPE "ReconciliationStatus" AS ENUM ('UNRECONCILED', 'RECONCILED');

-- CreateEnum
CREATE TYPE "ImportMappingTemplateType" AS ENUM ('BULK_IMPORT', 'RECONCILIATION');

-- AlterTable
ALTER TABLE "ImportMappingTemplate" ADD COLUMN     "type" "ImportMappingTemplateType" NOT NULL DEFAULT 'BULK_IMPORT';

-- CreateTable
CREATE TABLE "ReconciliationHistory" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "carrier" TEXT NOT NULL,
    "invoiceId" TEXT NOT NULL,
    "fileName" TEXT NOT NULL,
    "fileReference" TEXT NOT NULL,
    "numberOfShipments" INTEGER NOT NULL DEFAULT 0,
    "unreconciled" INTEGER NOT NULL DEFAULT 0,
    "reconciled" INTEGER NOT NULL DEFAULT 0,
    "dispute" INTEGER NOT NULL DEFAULT 0,
    "totalDiscrepancy" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "adjustedDiscrepancy" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "quotedTotal" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "billTotal" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "reratedTotal" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "shipmentReferenceId" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMPTZ(6),
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,

    CONSTRAINT "ReconciliationHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReconciliationData" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "invoiceId" TEXT NOT NULL,
    "fromZone" TEXT NOT NULL,
    "toZone" TEXT NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL,
    "quantity" INTEGER NOT NULL,
    "adjustedDiscrepancy" DOUBLE PRECISION,
    "shipmentReferenceId" TEXT,
    "quotedShipment" JSONB,
    "supplierBill" JSONB,
    "rerating" JSONB,
    "sender" JSONB,
    "receiver" JSONB,
    "notes" TEXT,
    "isDisputed" BOOLEAN NOT NULL DEFAULT false,
    "status" "ReconciliationStatus" NOT NULL DEFAULT 'UNRECONCILED',
    "errorMessage" TEXT,
    "discrepancy" DOUBLE PRECISION,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMPTZ(6),
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "reconciliationId" UUID NOT NULL,

    CONSTRAINT "ReconciliationData_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ReconciliationData" ADD CONSTRAINT "ReconciliationData_reconciliationId_fkey" FOREIGN KEY ("reconciliationId") REFERENCES "ReconciliationHistory"("id") ON DELETE CASCADE ON UPDATE CASCADE;
