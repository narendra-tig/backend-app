-- CreateIndex
CREATE INDEX "zone_suburb_trgm_index" ON "Zone" USING GIN ("suburb" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "zone_eta_from_zone_trgm_index" ON "ZoneETA" USING GIN ("fromZone" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "zone_eta_to_suburb_trgm_index" ON "ZoneETA" USING GIN ("toSuburb" gin_trgm_ops);
