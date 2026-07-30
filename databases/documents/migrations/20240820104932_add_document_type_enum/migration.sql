/*
  Warnings:

  - A unique constraint covering the columns `[data]` on the table `Document` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterEnum
ALTER TYPE "DocumentType" ADD VALUE 'REPORT_PDF';

-- CreateIndex
CREATE UNIQUE INDEX "Document_data_key" ON "Document"("data");
