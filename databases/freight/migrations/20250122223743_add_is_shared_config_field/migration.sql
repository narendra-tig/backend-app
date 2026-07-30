-- AlterTable
ALTER TABLE "CustomerGroupCarrier" ADD COLUMN     "isSharedConfig" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "CustomerGroupCarrierService" ADD COLUMN     "isSharedConfig" BOOLEAN NOT NULL DEFAULT false;