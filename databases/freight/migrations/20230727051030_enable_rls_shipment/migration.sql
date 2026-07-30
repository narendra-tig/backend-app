-- Enable RLS

ALTER TABLE "TaskQuoteResult" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "TaskQuoteResult" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "TaskQuoteResult" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "TaskQuoteResult" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Shipment" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Shipment" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Shipment" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Shipment" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Package" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Package" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Package" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Package" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "PalletsManagement" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "PalletsManagement" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "PalletsManagement" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "PalletsManagement" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Paperwork" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Paperwork" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Paperwork" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Paperwork" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Pickup" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Pickup" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Pickup" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Pickup" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "ShipmentDetails" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "ShipmentDetails" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "ShipmentDetails" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "ShipmentDetails" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Sender" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Sender" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Sender" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Sender" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Receiver" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Receiver" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Receiver" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Receiver" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

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
