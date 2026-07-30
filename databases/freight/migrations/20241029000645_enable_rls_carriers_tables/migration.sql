-- Enable RLS

ALTER TABLE "AccountCarrier" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "AccountCarrier" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "AccountCarrier" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "AccountCarrier" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "AccountCarrierService" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "AccountCarrierService" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "AccountCarrierService" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "AccountCarrierService" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "CarrierConnection" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CarrierConnection" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "CarrierConnection" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "CarrierConnection" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "InternalServiceCode" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "InternalServiceCode" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "InternalServiceCode" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "InternalServiceCode" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "ShipmentMetadata" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "ShipmentMetadata" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "ShipmentMetadata" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "ShipmentMetadata" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "CustomerGroupCarrier" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CustomerGroupCarrier" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "CustomerGroupCarrier" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "CustomerGroupCarrier" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "CustomerGroupCarrierService" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CustomerGroupCarrierService" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "CustomerGroupCarrierService" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "CustomerGroupCarrierService" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "FuelLevy" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "FuelLevy" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "FuelLevy" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "FuelLevy" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "FuelLevyVersion" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "FuelLevyVersion" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "FuelLevyVersion" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "FuelLevyVersion" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "SupplierOffline" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "SupplierOffline" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "SupplierOffline" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "SupplierOffline" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "ServiceDetails" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "ServiceDetails" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "ServiceDetails" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "ServiceDetails" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "SupplierService" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "SupplierService" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "SupplierService" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "SupplierService" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "PackageType" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "PackageType" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "PackageType" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "PackageType" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "SupplierContact" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "SupplierContact" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "SupplierContact" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "SupplierContact" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "SupplierTracking" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "SupplierTracking" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "SupplierTracking" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "SupplierTracking" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Depot" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Depot" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Depot" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Depot" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "DepotDetails" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "DepotDetails" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "DepotDetails" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "DepotDetails" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "DepotService" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "DepotService" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "DepotService" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "DepotService" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "DepotPackageType" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "DepotPackageType" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "DepotPackageType" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "DepotPackageType" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "DepotContact" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "DepotContact" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "DepotContact" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "DepotContact" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "DepotAttachment" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "DepotAttachment" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "DepotAttachment" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "DepotAttachment" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "SupplierAttachment" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "SupplierAttachment" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "SupplierAttachment" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "SupplierAttachment" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "RateCard" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "RateCard" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "RateCard" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "RateCard" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "RateCardLane" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "RateCardLane" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "RateCardLane" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "RateCardLane" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "RateCardPriceBreak" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "RateCardPriceBreak" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "RateCardPriceBreak" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "RateCardPriceBreak" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "RateCardAttachedAccount" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "RateCardAttachedAccount" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "RateCardAttachedAccount" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "RateCardAttachedAccount" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Rule" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Rule" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Rule" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Rule" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Surcharge" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Surcharge" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Surcharge" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Surcharge" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "SurchargeVersion" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "SurchargeVersion" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "SurchargeVersion" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "SurchargeVersion" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "TenancyCarrier" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "TenancyCarrier" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "TenancyCarrier" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "TenancyCarrier" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "TenancyCarrierService" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "TenancyCarrierService" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "TenancyCarrierService" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "TenancyCarrierService" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "TenancyCarrierProfile" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "TenancyCarrierProfile" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "TenancyCarrierProfile" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "TenancyCarrierProfile" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "PlatformTrackingEvent" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "PlatformTrackingEvent" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "PlatformTrackingEvent" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "PlatformTrackingEvent" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "CarrierTrackingEvent" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CarrierTrackingEvent" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "CarrierTrackingEvent" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "CarrierTrackingEvent" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

