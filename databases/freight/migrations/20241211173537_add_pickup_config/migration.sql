-- CreateEnum
CREATE TYPE "PickupType" AS ENUM ('PT_AUTOBOOK', 'PT_PERMANENT');

-- CreateTable
CREATE TABLE "PickupConfig" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "accountName" TEXT NOT NULL,
    "customerGroupId" UUID NOT NULL,
    "supplierName" TEXT NOT NULL,
    "serviceName" TEXT NOT NULL,
    "serviceId" UUID NOT NULL,
    "pickupType" "PickupType" NOT NULL DEFAULT 'PT_PERMANENT',
    "specialInstructionsAndNotes" TEXT NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "accountId" UUID NOT NULL DEFAULT (current_setting('app.account_id'::text))::uuid,
    "closeTime" TEXT,
    "pickupTimeZone" TEXT,
    "pickupArea" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PickupConfig_pkey" PRIMARY KEY ("id")
);

ALTER TABLE "PickupConfig" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "PickupConfig" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "PickupConfig" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "PickupConfig" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');