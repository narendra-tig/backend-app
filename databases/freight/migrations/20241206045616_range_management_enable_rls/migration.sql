ALTER TABLE "RangeManagementId" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "RangeManagementId" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "RangeManagementId" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "RangeManagementId" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');