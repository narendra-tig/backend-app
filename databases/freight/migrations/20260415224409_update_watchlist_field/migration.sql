/*
  Warnings:

  - Changed the type of `watchUntil` on the `Watchlist` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "Watchlist" DROP COLUMN "watchUntil",
ADD COLUMN     "watchUntil" TEXT NOT NULL;
