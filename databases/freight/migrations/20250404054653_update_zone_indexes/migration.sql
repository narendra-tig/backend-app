-- DropIndex
DROP INDEX "zone_postcode_suburb_index";

-- CreateIndex
CREATE INDEX "zone_postcode_suburb_zoneCardId_index" ON "Zone"("postCode", "suburb", "zoneCardId");

-- CreateIndex
CREATE INDEX "zone_eta_fromZone_toSuburb_toPostcode_zoneETACardId_index" ON "ZoneETA"("fromZone", "toSuburb", "toPostcode", "zoneETACardId");
