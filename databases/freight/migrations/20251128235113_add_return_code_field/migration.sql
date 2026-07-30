-- AlterEnum
ALTER TYPE "public"."ShipmentStatus" ADD VALUE 'RETURNED';

-- AlterTable
ALTER TABLE "public"."Shipment" ADD COLUMN     "returnCode" TEXT;