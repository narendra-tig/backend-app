-- DropForeignKey
ALTER TABLE "AccessibilitySettings" DROP CONSTRAINT "AccessibilitySettings_tenantId_fkey";

-- DropForeignKey
ALTER TABLE "OrganisationalUnit" DROP CONSTRAINT "OrganisationalUnit_tenantId_fkey";

-- DropForeignKey
ALTER TABLE "OrganisationalUnitEdge" DROP CONSTRAINT "OrganisationalUnitEdge_tenantId_fkey";

-- DropForeignKey
ALTER TABLE "TenantDetails" DROP CONSTRAINT "TenantDetails_tenantId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_organisationalUnitId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_tenantId_fkey";

-- AddForeignKey
ALTER TABLE "OrganisationalUnit" ADD CONSTRAINT "OrganisationalUnit_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrganisationalUnitEdge" ADD CONSTRAINT "OrganisationalUnitEdge_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TenantDetails" ADD CONSTRAINT "TenantDetails_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_organisationalUnitId_fkey" FOREIGN KEY ("organisationalUnitId") REFERENCES "OrganisationalUnit"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AccessibilitySettings" ADD CONSTRAINT "AccessibilitySettings_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;
