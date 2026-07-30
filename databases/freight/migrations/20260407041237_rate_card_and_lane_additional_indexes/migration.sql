-- CreateIndex
CREATE INDEX "rate_card_tenant_account_carrier_status_index" ON "RateCard"("tenantId", "accountId", "tenancyCarrierId", "status");

-- CreateIndex
CREATE INDEX "rate_card_lane_lookup_index" ON "RateCardLane"("rateCardId", "service", "from", "to");
