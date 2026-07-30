-- AlterTable
ALTER TABLE "CarrierTrackingEvent" ALTER COLUMN "tenantId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "PlatformTrackingEvent" ALTER COLUMN "tenantId" DROP NOT NULL;
