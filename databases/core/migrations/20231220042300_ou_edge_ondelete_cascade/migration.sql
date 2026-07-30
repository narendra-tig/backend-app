-- DropForeignKey
ALTER TABLE "OrganisationalUnitEdge" DROP CONSTRAINT "OrganisationalUnitEdge_fromId_fkey";

-- DropForeignKey
ALTER TABLE "OrganisationalUnitEdge" DROP CONSTRAINT "OrganisationalUnitEdge_toId_fkey";

-- AddForeignKey
ALTER TABLE "OrganisationalUnitEdge" ADD CONSTRAINT "OrganisationalUnitEdge_fromId_fkey" FOREIGN KEY ("fromId") REFERENCES "OrganisationalUnit"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrganisationalUnitEdge" ADD CONSTRAINT "OrganisationalUnitEdge_toId_fkey" FOREIGN KEY ("toId") REFERENCES "OrganisationalUnit"("id") ON DELETE CASCADE ON UPDATE CASCADE;
