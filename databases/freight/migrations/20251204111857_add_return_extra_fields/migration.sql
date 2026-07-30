-- AlterTable
ALTER TABLE "public"."ShipmentDetails" ADD COLUMN     "isReturnConfirmed" BOOLEAN DEFAULT false,
ADD COLUMN     "isReturnEmailSent" BOOLEAN;
