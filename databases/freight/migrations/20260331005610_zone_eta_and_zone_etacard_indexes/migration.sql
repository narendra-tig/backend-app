-- CreateIndex
CREATE INDEX "zone_eta_card_zone_lookup_index" ON "ZoneETA"("zoneETACardId", "fromZone", "toPostcode", "toSuburb");

-- CreateIndex
CREATE INDEX "zone_eta_cardId_toPostcode_index" ON "ZoneETA"("zoneETACardId", "toPostcode");

-- CreateIndex
CREATE INDEX "zone_eta_card_carrier_date_range_index" ON "ZoneETACard"("masterCarrierId", "start", "end");

-- CreateIndex
CREATE INDEX "zone_eta_card_carrier_service_date_index" ON "ZoneETACard"("masterCarrierId", "masterCarrierServiceId", "start", "end");
