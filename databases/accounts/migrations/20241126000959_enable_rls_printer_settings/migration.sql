-- This is an empty migration.-- Enable RLS

ALTER TABLE "PrinterSetting" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "PrinterSetting" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "PrinterSetting" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "PrinterSetting" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');