-- AlterTable
ALTER TABLE "public"."ShipmentImportData" ADD COLUMN     "errorMessage" TEXT,
ADD COLUMN     "shipmentCreateResult" JSONB;
