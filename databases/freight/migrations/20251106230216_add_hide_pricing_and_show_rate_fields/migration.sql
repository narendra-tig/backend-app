-- AlterTable
ALTER TABLE "ShipmentPreference" ADD COLUMN     "enableRatesAndQuoting" BOOLEAN DEFAULT false,
ADD COLUMN     "hidePricing" BOOLEAN DEFAULT false;
