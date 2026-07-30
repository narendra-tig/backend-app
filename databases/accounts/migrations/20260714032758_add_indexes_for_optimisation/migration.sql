-- DropIndex
DROP INDEX "public"."idx_depot_locations_resource_resource_id";

-- DropIndex
DROP INDEX "public"."idx_dispatch_locations_resource_resource_id";

-- DropIndex
DROP INDEX "public"."idx_receiver_locations_resource_resource_id";

-- CreateIndex
CREATE INDEX "idx_account_tenant_status" ON "Account"("tenantId", "status");

-- CreateIndex
CREATE INDEX "idx_custom_package_tenant_account_id" ON "CustomPackage"("tenantId", "accountId");

-- CreateIndex
CREATE INDEX "idx_customer_group_tenant_account_id" ON "CustomerGroup"("tenantId", "accountId");

-- CreateIndex
CREATE INDEX "idx_depot_locations_tenant_resource_id" ON "DepotLocation"("tenantId", "resourceId");

-- CreateIndex
CREATE INDEX "idx_dispatch_locations_tenant_resource_id" ON "DispatchLocation"("tenantId", "resourceId");

-- CreateIndex
CREATE INDEX "idx_enquiry_notification_tenant_account_id" ON "EnquiryNotification"("tenantId", "accountId");

-- CreateIndex
CREATE INDEX "idx_invoices_tenant_customer_group_id" ON "Invoices"("tenantId", "customerGroupId");

-- CreateIndex
CREATE INDEX "idx_location_tenant_id" ON "Location"("tenantId");

-- CreateIndex
CREATE INDEX "idx_receiver_locations_tenant_resource_id" ON "ReceiverLocationV2"("tenantId", "resourceId");
