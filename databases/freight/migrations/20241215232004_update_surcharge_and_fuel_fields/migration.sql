/*
  Warnings:

  - You are about to drop the column `codeIndex` on the `FuelLevyVersion` table. All the data in the column will be lost.
  - You are about to drop the column `codeIndex` on the `SurchargeVersion` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "FuelLevy" ADD COLUMN     "codeIndex" SERIAL NOT NULL,
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "FuelLevyVersion" DROP COLUMN "codeIndex",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "sellValue" SET DATA TYPE DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Surcharge" ADD COLUMN     "codeIndex" SERIAL NOT NULL,
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "SurchargeVersion" DROP COLUMN "codeIndex",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "sellValue" SET DATA TYPE DOUBLE PRECISION;
