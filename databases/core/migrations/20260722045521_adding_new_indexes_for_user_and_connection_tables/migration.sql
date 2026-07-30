-- CreateIndex
CREATE INDEX "Connection_tenantId_appModuleType_idx" ON "Connection"("tenantId", "appModuleType");

-- CreateIndex
CREATE INDEX "Connection_organisationalUnitId_idx" ON "Connection"("organisationalUnitId");

-- CreateIndex
CREATE INDEX "User_tenantId_idx" ON "User"("tenantId");

-- CreateIndex
CREATE INDEX "User_organisationalUnitId_idx" ON "User"("organisationalUnitId");
