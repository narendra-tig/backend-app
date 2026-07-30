/*
  Warnings:

  - You are about to drop the column `code` on the `CustomPackage` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "CustomPackage" DROP COLUMN "code",
ADD COLUMN  "reference" TEXT;
