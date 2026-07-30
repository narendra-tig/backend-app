-- CreateIndex
CREATE INDEX "surcharge_sub_category_default_carrier_index" ON "Surcharge"("subCategoryId", "isDefault", "tenancyCarrierId");

-- CreateIndex
CREATE INDEX "surcharge_category_name_trgm_index" ON "SurchargeCategory" USING GIN ("name" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "surcharge_sub_category_name_trgm_index" ON "SurchargeSubCategory" USING GIN ("name" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "surcharge_version_date_status_index" ON "SurchargeVersion"("startDate", "endDate", "status");

-- CreateIndex
CREATE INDEX "surcharge_version_date_status_code_index" ON "SurchargeVersion"("startDate", "endDate", "status", "code");
