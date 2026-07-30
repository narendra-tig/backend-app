-- This is an empty migration.-- Enable RLS

ALTER TABLE "UserCredentials" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "UserCredentials" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "UserCredentials" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "UserCredentials" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "UserAuthenticationProvider" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "UserAuthenticationProvider" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "UserAuthenticationProvider" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "UserAuthenticationProvider" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "UserSession" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "UserSession" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "UserSession" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "UserSession" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');