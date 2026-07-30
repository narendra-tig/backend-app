-- CreateIndex
CREATE INDEX "fuel_levy_default_tenancy_carrier_index" ON "FuelLevy"("isDefault", "tenancyCarrierId");

-- CreateIndex
CREATE INDEX "fuel_levy_version_date_status_index" ON "FuelLevyVersion"("startDate", "endDate", "status");

-- CreateIndex
CREATE INDEX "fuel_levy_version_status_code_date_index" ON "FuelLevyVersion"("status", "code", "startDate", "endDate");

-- CreateIndex
CREATE INDEX "fuel_levy_version_type_status_date_index" ON "FuelLevyVersion"("type", "status", "startDate", "endDate");
