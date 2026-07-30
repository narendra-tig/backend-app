-- AlterTable
ALTER TABLE "FuelLevy" ADD COLUMN     "isDefault" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "Surcharge" ADD COLUMN     "isDefault" BOOLEAN NOT NULL DEFAULT false;
