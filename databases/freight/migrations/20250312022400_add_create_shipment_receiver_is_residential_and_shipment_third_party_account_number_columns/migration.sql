-- AlterTable
ALTER TABLE "Receiver" ADD COLUMN     "isResidential" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "ShipmentDetails" ADD COLUMN     "thirdPartyAccountNumber" TEXT;