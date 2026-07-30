-- This is an empty migration.-- Enable RLS

ALTER TABLE "TenancyCarrierConfig" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "TenancyCarrierConfig" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "TenancyCarrierConfig" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "TenancyCarrierConfig" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "AccountCarrierConfig" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "AccountCarrierConfig" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "AccountCarrierConfig" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "AccountCarrierConfig" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "CustomerGroupCarrierConfig" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CustomerGroupCarrierConfig" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "CustomerGroupCarrierConfig" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "CustomerGroupCarrierConfig" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');
