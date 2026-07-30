-- AlterTable
ALTER TABLE "ShipmentPreference" ADD COLUMN     "allowThirdPartyPays" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "costCentreRequired" BOOLEAN NOT NULL DEFAULT false;
