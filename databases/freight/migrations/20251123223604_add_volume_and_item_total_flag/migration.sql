-- AlterTable
ALTER TABLE "public"."Package" ADD COLUMN     "volume" DECIMAL(65,30);

-- AlterTable
ALTER TABLE "public"."ShipmentDetails" ADD COLUMN     "enableItemAsTotal" BOOLEAN DEFAULT false;
