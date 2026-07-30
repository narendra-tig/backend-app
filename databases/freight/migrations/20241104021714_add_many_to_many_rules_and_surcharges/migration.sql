/*
  Warnings:

  - You are about to drop the column `surchargeId` on the `Rule` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Rule" DROP CONSTRAINT "Rule_surchargeId_fkey";

-- AlterTable
ALTER TABLE "Rule" DROP COLUMN "surchargeId";

-- CreateTable
CREATE TABLE "_RuleToSurcharge" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_RuleToSurcharge_AB_unique" ON "_RuleToSurcharge"("A", "B");

-- CreateIndex
CREATE INDEX "_RuleToSurcharge_B_index" ON "_RuleToSurcharge"("B");

-- AddForeignKey
ALTER TABLE "_RuleToSurcharge" ADD CONSTRAINT "_RuleToSurcharge_A_fkey" FOREIGN KEY ("A") REFERENCES "Rule"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RuleToSurcharge" ADD CONSTRAINT "_RuleToSurcharge_B_fkey" FOREIGN KEY ("B") REFERENCES "Surcharge"("id") ON DELETE CASCADE ON UPDATE CASCADE;
