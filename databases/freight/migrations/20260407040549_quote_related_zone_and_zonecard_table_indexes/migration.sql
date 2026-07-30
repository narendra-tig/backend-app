-- CreateIndex
CREATE INDEX "zone_postcode_suburb_index" ON "Zone"("postCode", "suburb");

-- CreateIndex
CREATE INDEX "zone_card_id_master_carrier_id_index" ON "ZoneCard"("id", "masterCarrierId");
