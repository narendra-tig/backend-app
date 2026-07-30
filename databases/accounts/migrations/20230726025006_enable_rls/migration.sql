-- Enable RLS

ALTER TABLE "Account" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Account" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Account" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Account" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "AccountLink" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "AccountLink" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "AccountLink" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "AccountLink" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "CustomerGroup" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CustomerGroup" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "CustomerGroup" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "CustomerGroup" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Location" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Location" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Location" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Location" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Address" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Address" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Address" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Address" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Contact" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Contact" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Contact" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Contact" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');