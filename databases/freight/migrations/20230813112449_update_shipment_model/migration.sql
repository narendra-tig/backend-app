/*
  Warnings:

  - You are about to drop the column `carrierId` on the `Shipment` table. All the data in the column will be lost.
  - You are about to drop the column `serviceId` on the `Shipment` table. All the data in the column will be lost.
  - Added the required column `accountId` to the `Shipment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `carrier` to the `Shipment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `customerGroupId` to the `Shipment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `service` to the `Shipment` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "Command" ADD VALUE 'CREATE_LABEL';
ALTER TYPE "Command" ADD VALUE 'MANIFEST_SHIPMENTS';

-- AlterTable
ALTER TABLE "Shipment" DROP COLUMN "carrierId",
DROP COLUMN "serviceId",
ADD COLUMN     "accountId" UUID NOT NULL,
ADD COLUMN     "carrier" TEXT NOT NULL,
ADD COLUMN     "customerGroupId" UUID NOT NULL,
ADD COLUMN     "service" TEXT NOT NULL;
