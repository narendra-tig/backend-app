-- CreateIndex
CREATE INDEX "FuelLevy_tenancyCarrierId_idx" ON "FuelLevy" USING HASH ("tenancyCarrierId");

-- CreateIndex
CREATE INDEX "FuelLevy_accountCarrierId_idx" ON "FuelLevy" USING HASH ("accountCarrierId");

-- CreateIndex
CREATE INDEX "FuelLevyVersion_fuelLevyId_idx" ON "FuelLevyVersion" USING HASH ("fuelLevyId");

-- CreateIndex
CREATE INDEX "RateCard_tenancyCarrierId_idx" ON "RateCard" USING HASH ("tenancyCarrierId");

-- CreateIndex
CREATE INDEX "RateCardLane_rateCardId_idx" ON "RateCardLane" USING HASH ("rateCardId");

-- CreateIndex
CREATE INDEX "RateCardLane_tenacnyCarrierServiceId_idx" ON "RateCardLane" USING HASH ("tenacnyCarrierServiceId");

-- CreateIndex
CREATE INDEX "RateCardPriceBreak_rateCardLaneId_idx" ON "RateCardPriceBreak" USING HASH ("rateCardLaneId");

-- CreateIndex
CREATE INDEX "Surcharge_tenancyCarrierId_idx" ON "Surcharge" USING HASH ("tenancyCarrierId");

-- CreateIndex
CREATE INDEX "Surcharge_accountCarrierId_idx" ON "Surcharge" USING HASH ("accountCarrierId");

-- CreateIndex
CREATE INDEX "SurchargeVersion_surchargeId_idx" ON "SurchargeVersion" USING HASH ("surchargeId");
