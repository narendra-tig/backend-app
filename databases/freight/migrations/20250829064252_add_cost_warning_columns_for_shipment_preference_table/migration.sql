-- AlterTable
ALTER TABLE "public"."ShipmentPreference" ADD COLUMN     "consignmentCostWarningThreshold" INTEGER DEFAULT 0,
ADD COLUMN     "enableConsignmentCostWarning" BOOLEAN NOT NULL DEFAULT false;
