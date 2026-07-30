-- AlterTable
ALTER TABLE "TenancyCarrier" ADD COLUMN     "isEnabled" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "TenancyCarrierService" ADD COLUMN     "isEnabled" BOOLEAN NOT NULL DEFAULT false;
