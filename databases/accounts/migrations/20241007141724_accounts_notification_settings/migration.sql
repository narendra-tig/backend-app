-- CreateTable
CREATE TABLE "AccountSettings" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "accountId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "smsEnabled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "AccountSettings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomerGroupSettings" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "customerGroupId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "smsEnabled" BOOLEAN NOT NULL DEFAULT false,
    "trackingNotificationManifestedEnabled" BOOLEAN NOT NULL DEFAULT false,
    "trackingNotificationOnboardForDeliveryEnabled" BOOLEAN NOT NULL DEFAULT false,
    "trackingNotificationDeliveredEnabled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "CustomerGroupSettings_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "AccountSettings_accountId_key" ON "AccountSettings"("accountId");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerGroupSettings_customerGroupId_key" ON "CustomerGroupSettings"("customerGroupId");

-- AddForeignKey
ALTER TABLE "AccountSettings" ADD CONSTRAINT "AccountSettings_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerGroupSettings" ADD CONSTRAINT "CustomerGroupSettings_customerGroupId_fkey" FOREIGN KEY ("customerGroupId") REFERENCES "CustomerGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "AccountSettings" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "AccountSettings" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "AccountSettings" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "AccountSettings" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "CustomerGroupSettings" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CustomerGroupSettings" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "CustomerGroupSettings" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "CustomerGroupSettings" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');
