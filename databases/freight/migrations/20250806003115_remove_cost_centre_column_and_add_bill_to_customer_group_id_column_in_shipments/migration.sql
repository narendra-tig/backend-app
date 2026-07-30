/*
  Warnings:

  - You are about to drop the column `costCentre` on the `DraftShipment` table. All the data in the column will be lost.
  - You are about to drop the column `costCentre` on the `ShipmentDetails` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "public"."DraftShipment" DROP COLUMN "costCentre";

-- AlterTable
ALTER TABLE "public"."ShipmentDetails" DROP COLUMN "costCentre",
ADD COLUMN     "billToCustomerGroupId" UUID;
