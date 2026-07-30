/*
  Warnings:

  - A unique constraint covering the columns `[fromId,toId]` on the table `OrganisationalUnitEdge` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "OrganisationalUnitEdge_fromId_toId_key" ON "OrganisationalUnitEdge"("fromId", "toId");
