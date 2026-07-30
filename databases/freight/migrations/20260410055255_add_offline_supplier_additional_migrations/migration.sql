-- CreateIndex
CREATE INDEX "PackageType_serviceDetailsId_idx" ON "PackageType"("serviceDetailsId");

-- CreateIndex
CREATE INDEX "PackageType_serviceDetailsId_name_idx" ON "PackageType"("serviceDetailsId", "name");

-- CreateIndex
CREATE INDEX "package_type_name_trgm_index" ON "PackageType" USING GIN ("name" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "ServiceDetails_supplierId_idx" ON "ServiceDetails"("supplierId");

-- CreateIndex
CREATE INDEX "service_details_area_trgm_index" ON "ServiceDetails" USING GIN ("area" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "service_details_phone_number_trgm_index" ON "ServiceDetails" USING GIN ("phoneNumber" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "SupplierAttachment_supplierId_idx" ON "SupplierAttachment"("supplierId");

-- CreateIndex
CREATE INDEX "SupplierContact_supplierId_idx" ON "SupplierContact"("supplierId");

-- CreateIndex
CREATE INDEX "SupplierContact_supplierId_name_idx" ON "SupplierContact"("supplierId", "name");

-- CreateIndex
CREATE INDEX "supplier_contact_name_trgm_index" ON "SupplierContact" USING GIN ("name" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "SupplierOffline_tenantId_idx" ON "SupplierOffline"("tenantId");

-- CreateIndex
CREATE INDEX "SupplierOffline_tenantId_isStarred_idx" ON "SupplierOffline"("tenantId", "isStarred");

-- CreateIndex
CREATE INDEX "SupplierOffline_tenantId_name_idx" ON "SupplierOffline"("tenantId", "name");

-- CreateIndex
CREATE INDEX "supplier_offline_name_trgm_index" ON "SupplierOffline" USING GIN ("name" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "SupplierService_serviceDetailsId_idx" ON "SupplierService"("serviceDetailsId");

-- CreateIndex
CREATE INDEX "SupplierService_serviceDetailsId_name_idx" ON "SupplierService"("serviceDetailsId", "name");

-- CreateIndex
CREATE INDEX "supplier_service_name_trgm_index" ON "SupplierService" USING GIN ("name" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "SupplierTracking_supplierId_idx" ON "SupplierTracking"("supplierId");
