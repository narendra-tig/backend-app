-- AlterTable
ALTER TABLE "FuelLevy" ADD COLUMN     "endDate" TIMESTAMP(3),
ADD COLUMN     "notes" TEXT;

-- AlterTable
ALTER TABLE "RateCard" ADD COLUMN     "customerGroupId" UUID,
ADD COLUMN     "notes" TEXT,
ADD COLUMN     "zoneFrom" TEXT,
ADD COLUMN     "zoneTo" TEXT;

-- AlterTable
ALTER TABLE "Surcharge" ADD COLUMN     "endDate" TIMESTAMP(3),
ADD COLUMN     "notes" TEXT;