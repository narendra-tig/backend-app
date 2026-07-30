/*
  Warnings:

  - You are about to drop the column `fileName` on the `Invoices` table. All the data in the column will be lost.
  - You are about to drop the column `fileReference` on the `Invoices` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Invoices" DROP COLUMN "fileName",
DROP COLUMN "fileReference",
ADD COLUMN     "csvFileName" TEXT,
ADD COLUMN     "csvFileURL" TEXT,
ADD COLUMN     "pdfFileName" TEXT,
ADD COLUMN     "pdfFileURL" TEXT;
