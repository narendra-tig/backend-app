-- CreateIndex
CREATE INDEX "Depot_tenantId_idx" ON "Depot"("tenantId");

-- CreateIndex
CREATE INDEX "Depot_tenantId_isStarred_idx" ON "Depot"("tenantId", "isStarred");

-- CreateIndex
CREATE INDEX "Depot_tenantId_name_idx" ON "Depot"("tenantId", "name");

-- CreateIndex
CREATE INDEX "depot_name_trgm_index" ON "Depot" USING GIN ("name" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "DepotAttachment_depotId_idx" ON "DepotAttachment"("depotId");

-- CreateIndex
CREATE INDEX "DepotContact_depotId_idx" ON "DepotContact"("depotId");

-- CreateIndex
CREATE INDEX "DepotContact_depotId_name_idx" ON "DepotContact"("depotId", "name");

-- CreateIndex
CREATE INDEX "depot_contact_name_trgm_index" ON "DepotContact" USING GIN ("name" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "DepotDetails_depotId_idx" ON "DepotDetails"("depotId");

-- CreateIndex
CREATE INDEX "depot_details_area_trgm_index" ON "DepotDetails" USING GIN ("area" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "depot_details_phone_number_trgm_index" ON "DepotDetails" USING GIN ("phoneNumber" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "DepotPackageType_depotDetailsId_idx" ON "DepotPackageType"("depotDetailsId");

-- CreateIndex
CREATE INDEX "DepotPackageType_depotDetailsId_name_idx" ON "DepotPackageType"("depotDetailsId", "name");

-- CreateIndex
CREATE INDEX "depot_package_type_name_trgm_index" ON "DepotPackageType" USING GIN ("name" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "DepotService_depotDetailsId_name_idx" ON "DepotService"("depotDetailsId", "name");

-- CreateIndex
CREATE INDEX "depot_service_name_trgm_index" ON "DepotService" USING GIN ("name" gin_trgm_ops);
