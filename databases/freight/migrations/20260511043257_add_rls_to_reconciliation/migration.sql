-- Enable RLS on ReconciliationHistory
ALTER TABLE "ReconciliationHistory" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "ReconciliationHistory" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "ReconciliationHistory" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "ReconciliationHistory" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

-- Enable RLS on ReconciliationData
ALTER TABLE "ReconciliationData" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "ReconciliationData" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "ReconciliationData" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "ReconciliationData" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');