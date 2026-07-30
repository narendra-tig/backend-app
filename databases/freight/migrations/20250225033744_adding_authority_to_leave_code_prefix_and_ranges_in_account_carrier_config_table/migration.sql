-- AlterTable
ALTER TABLE "AccountCarrierConfig" ADD COLUMN     "atlCodeLength" INTEGER,
ADD COLUMN     "atlCodeMax" INTEGER,
ADD COLUMN     "atlCodeMin" INTEGER,
ADD COLUMN     "atlCodeNextId" INTEGER,
ADD COLUMN     "atlCodePrefix" TEXT;
