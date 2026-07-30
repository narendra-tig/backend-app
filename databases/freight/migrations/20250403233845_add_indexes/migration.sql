-- CreateIndex
CREATE INDEX "RateCard_accountId_idx" ON "RateCard" USING HASH ("accountId");

-- CreateIndex
CREATE INDEX "RateCardLane_from_idx" ON "RateCardLane" USING HASH ("from");

-- CreateIndex
CREATE INDEX "RateCardLane_to_idx" ON "RateCardLane" USING HASH ("to");

-- CreateIndex
CREATE INDEX "zone_postcode_suburb_index" ON "Zone"("postCode", "suburb");
