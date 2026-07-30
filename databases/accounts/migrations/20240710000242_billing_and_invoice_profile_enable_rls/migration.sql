ALTER TABLE "BillingProfile" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "BillingProfile" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "BillingProfile" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "BillingProfile" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "BillingInvoiceReceiver" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "BillingInvoiceReceiver" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "BillingInvoiceReceiver" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "BillingInvoiceReceiver" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');