-- CreateEnum
CREATE TYPE "FuelLevyBuyType" AS ENUM ('FUEL_BUY_FIXED', 'FUEL_BUY_MARKUP');

-- CreateEnum
CREATE TYPE "SurchargeBuyType" AS ENUM ('SURCHARGE_BUY_FIXED', 'SURCHARGE_BUY_MARKUP');

-- AlterTable
ALTER TABLE "FuelLevyVersion" ADD COLUMN     "buyType" "FuelLevyBuyType",
ALTER COLUMN "endDate" DROP NOT NULL;

-- AlterTable
ALTER TABLE "SurchargeVersion" ADD COLUMN     "buyType" "SurchargeBuyType",
ALTER COLUMN "endDate" DROP NOT NULL;
