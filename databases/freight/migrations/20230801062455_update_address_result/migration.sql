/*
  Warnings:

  - You are about to drop the column `citySuburbTown` on the `Address` table. All the data in the column will be lost.
  - Added the required column `suburb` to the `Address` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Address" DROP COLUMN "citySuburbTown",
ADD COLUMN     "suburb" TEXT NOT NULL;
