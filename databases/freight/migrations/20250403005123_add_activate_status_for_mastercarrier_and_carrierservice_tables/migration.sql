-- AlterTable
ALTER TABLE "MasterCarrier" ADD COLUMN     "isActivated" BOOLEAN NOT NULL DEFAULT true;

-- AlterTable
ALTER TABLE "MasterCarrierService" ADD COLUMN     "isActivated" BOOLEAN NOT NULL DEFAULT true;
