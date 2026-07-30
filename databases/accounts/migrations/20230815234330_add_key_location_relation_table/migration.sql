/*
  Warnings:

  - You are about to drop the `_AccountToLocation` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_AccountToLocation" DROP CONSTRAINT "_AccountToLocation_A_fkey";

-- DropForeignKey
ALTER TABLE "_AccountToLocation" DROP CONSTRAINT "_AccountToLocation_B_fkey";

-- DropTable
DROP TABLE "_AccountToLocation";

-- CreateTable
CREATE TABLE "_KeyLocation" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_KeyLocation_AB_unique" ON "_KeyLocation"("A", "B");

-- CreateIndex
CREATE INDEX "_KeyLocation_B_index" ON "_KeyLocation"("B");

-- AddForeignKey
ALTER TABLE "_KeyLocation" ADD CONSTRAINT "_KeyLocation_A_fkey" FOREIGN KEY ("A") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_KeyLocation" ADD CONSTRAINT "_KeyLocation_B_fkey" FOREIGN KEY ("B") REFERENCES "Location"("id") ON DELETE CASCADE ON UPDATE CASCADE;
