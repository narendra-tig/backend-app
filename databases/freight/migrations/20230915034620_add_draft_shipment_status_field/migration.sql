/*
  Warnings:

  - The `estimatedPrice` column on the `DraftShipment` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "DraftShipment" ADD COLUMN     "status" "ShipmentStatus",
DROP COLUMN "estimatedPrice",
ADD COLUMN     "estimatedPrice" MONEY;
