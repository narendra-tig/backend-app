-- AlterTable
ALTER TABLE "FuelLevy" ADD COLUMN     "carrier" TEXT,
ADD COLUMN     "currentVersionId" TEXT,
ADD COLUMN     "startDate" TIMESTAMP(3),
ADD COLUMN     "status" TEXT,
ADD COLUMN     "type" TEXT;

-- AlterTable
ALTER TABLE "Surcharge" ADD COLUMN     "carrier" TEXT,
ADD COLUMN     "currentVersionId" TEXT,
ADD COLUMN     "startDate" TIMESTAMP(3),
ADD COLUMN     "status" TEXT,
ADD COLUMN     "type" TEXT;
