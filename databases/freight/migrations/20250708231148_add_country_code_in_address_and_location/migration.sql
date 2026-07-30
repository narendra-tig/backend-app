-- AlterTable
ALTER TABLE "Address" ADD COLUMN     "countryCode" TEXT DEFAULT '';

-- AlterTable
ALTER TABLE "Locations" ADD COLUMN     "countryCode" TEXT DEFAULT '';
