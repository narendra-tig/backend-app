-- Enable RLS

ALTER TABLE "TenantDetails" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "TenantDetails" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "TenantDetails" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "TenantDetails" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "OrganisationalUnit" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "OrganisationalUnit" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "OrganisationalUnit" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "OrganisationalUnit" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "OrganisationalUnitEdge" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "OrganisationalUnitEdge" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "OrganisationalUnitEdge" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "OrganisationalUnitEdge" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "User" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "User" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "User" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "User" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "AccessibilitySettings" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "AccessibilitySettings" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "AccessibilitySettings" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "AccessibilitySettings" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');
