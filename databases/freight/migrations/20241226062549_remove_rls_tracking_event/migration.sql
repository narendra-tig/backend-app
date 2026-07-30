-- this is to remove rls tracking event table

ALTER TABLE "PlatformTrackingEvent" DISABLE ROW LEVEL SECURITY;
DROP POLICY tenant_isolation_policy ON "PlatformTrackingEvent";
DROP POLICY bypass_rls_policy ON "PlatformTrackingEvent";

ALTER TABLE "CarrierTrackingEvent" DISABLE ROW LEVEL SECURITY;
DROP POLICY tenant_isolation_policy ON "CarrierTrackingEvent";
DROP POLICY bypass_rls_policy ON "CarrierTrackingEvent";