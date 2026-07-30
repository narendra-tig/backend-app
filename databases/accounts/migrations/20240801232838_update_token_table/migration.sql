/*
  Warnings:

  - You are about to drop the column `carrierConnectionId` on the `PlatformTokenManagement` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "PlatformTokenManagement" DROP COLUMN "carrierConnectionId",
ADD COLUMN     "carrierConnectionIds" TEXT[],
ADD COLUMN     "carrierNames" TEXT[];
