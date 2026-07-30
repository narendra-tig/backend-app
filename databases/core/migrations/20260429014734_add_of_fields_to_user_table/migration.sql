/*
  Warnings:

  - The `ofId` column on the `User` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "User" ADD COLUMN     "deletedAt" TIMESTAMPTZ,
ADD COLUMN     "expiresAt" TIMESTAMPTZ,
DROP COLUMN "ofId",
ADD COLUMN     "ofId" INTEGER;
