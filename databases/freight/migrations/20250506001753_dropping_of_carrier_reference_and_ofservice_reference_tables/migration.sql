/*
  Warnings:

  - You are about to drop the `OfCarrierReference` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `OfCarrierServiceReference` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "OfCarrierReference" DROP CONSTRAINT "OfCarrierReference_masterCarrierId_fkey";

-- DropForeignKey
ALTER TABLE "OfCarrierServiceReference" DROP CONSTRAINT "OfCarrierServiceReference_masterCarrierServiceId_fkey";

-- DropTable
DROP TABLE "OfCarrierReference";

-- DropTable
DROP TABLE "OfCarrierServiceReference";
