-- AlterTable
ALTER TABLE "_KeyLocation" ADD CONSTRAINT "_KeyLocation_AB_pkey" PRIMARY KEY ("A", "B");

-- DropIndex
DROP INDEX "_KeyLocation_AB_unique";
