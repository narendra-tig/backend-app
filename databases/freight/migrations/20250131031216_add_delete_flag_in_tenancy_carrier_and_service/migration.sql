-- AlterTable
ALTER TABLE "TenancyCarrier" ADD COLUMN     "deleted" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "TenancyCarrierService" ADD COLUMN     "deleted" BOOLEAN NOT NULL DEFAULT false;
