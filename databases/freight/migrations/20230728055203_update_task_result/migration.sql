/*
  Warnings:

  - Added the required column `maxBusinessDays` to the `TaskQuoteResult` table without a default value. This is not possible if the table is not empty.
  - Added the required column `minBusinessDays` to the `TaskQuoteResult` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "TaskQuoteResult" ADD COLUMN     "maxBusinessDays" INTEGER NOT NULL,
ADD COLUMN     "minBusinessDays" INTEGER NOT NULL;
