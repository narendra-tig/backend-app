-- AlterTable
ALTER TABLE "AccountCarrierService" ADD COLUMN     "nextId" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "TenancyCarrierService" ADD COLUMN     "prefix" TEXT,
ADD COLUMN     "rangeMax" DOUBLE PRECISION,
ADD COLUMN     "rangeMin" DOUBLE PRECISION;
