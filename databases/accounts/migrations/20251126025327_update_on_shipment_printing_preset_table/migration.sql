/*
  Warnings:

  - You are about to drop the column `documentSelections` on the `ShipmentPrintingPresets` table. All the data in the column will be lost.
  - You are about to drop the column `printFormat` on the `ShipmentPrintingPresets` table. All the data in the column will be lost.
  - You are about to drop the column `printOrder1` on the `ShipmentPrintingPresets` table. All the data in the column will be lost.
  - You are about to drop the column `printOrder2` on the `ShipmentPrintingPresets` table. All the data in the column will be lost.
  - You are about to drop the column `printOrder3` on the `ShipmentPrintingPresets` table. All the data in the column will be lost.
  - You are about to drop the column `printOrder4` on the `ShipmentPrintingPresets` table. All the data in the column will be lost.
  - You are about to drop the column `printOrder5` on the `ShipmentPrintingPresets` table. All the data in the column will be lost.
  - You are about to drop the column `printOrder6` on the `ShipmentPrintingPresets` table. All the data in the column will be lost.
  - You are about to drop the column `printerType` on the `ShipmentPrintingPresets` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "public"."ShipmentPrintingPresets" DROP COLUMN "documentSelections",
DROP COLUMN "printFormat",
DROP COLUMN "printOrder1",
DROP COLUMN "printOrder2",
DROP COLUMN "printOrder3",
DROP COLUMN "printOrder4",
DROP COLUMN "printOrder5",
DROP COLUMN "printOrder6",
DROP COLUMN "printerType",
ADD COLUMN     "printOrderSelections" JSONB[];
