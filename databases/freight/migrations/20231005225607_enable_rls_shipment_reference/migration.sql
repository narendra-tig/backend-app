-- Enable RLS

ALTER TABLE "ShipmentReference" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "ShipmentReference" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "ShipmentReference" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "ShipmentReference" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');
