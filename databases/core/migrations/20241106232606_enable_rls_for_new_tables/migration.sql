-- Enable RLS

ALTER TABLE "Connection" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Connection" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Connection" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Connection" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Role" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Role" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Role" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Role" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "TimedToken" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "TimedToken" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "TimedToken" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "TimedToken" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "TenancyUser" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "TenancyUser" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "TenancyUser" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "TenancyUser" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "AccountUser" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "AccountUser" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "AccountUser" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "AccountUser" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "HubUser" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "HubUser" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "HubUser" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "HubUser" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');
