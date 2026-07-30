-- CreateTable
CREATE TABLE "CalculationBreakdown" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenantId" UUID NOT NULL,
    "serviceId" UUID,
    "fromPostCode" TEXT,
    "toPostCode" TEXT,
    "shipmentId" UUID,
    "manifestId" UUID,
    "quoteId" UUID,
    "surchargePrice" DOUBLE PRECISION,
    "fuelLevyPrice" DOUBLE PRECISION,
    "price" DOUBLE PRECISION,
    "currency" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CalculationBreakdown_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CalculationBreakdownSurcharge" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenantId" UUID NOT NULL,
    "calculationBreakdownId" UUID NOT NULL,
    "surchargeId" UUID NOT NULL,
    "sellValue" DOUBLE PRECISION NOT NULL,
    "sellType" TEXT NOT NULL,
    "buyValue" DOUBLE PRECISION NOT NULL,
    "buyType" TEXT NOT NULL,
    "ruleIds" TEXT[],
    "calculatedCharge" DOUBLE PRECISION NOT NULL,
    "surchargeDetails" JSONB NOT NULL,

    CONSTRAINT "CalculationBreakdownSurcharge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CalculationBreakdownFuelLevy" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenantId" UUID NOT NULL,
    "calculationBreakdownId" UUID NOT NULL,
    "sellValue" DOUBLE PRECISION NOT NULL,
    "sellType" TEXT NOT NULL,
    "buyValue" DOUBLE PRECISION NOT NULL,
    "buyType" TEXT NOT NULL,
    "calculatedCharge" DOUBLE PRECISION NOT NULL,
    "fuelLevyId" UUID NOT NULL,

    CONSTRAINT "CalculationBreakdownFuelLevy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CalculationBreakdownRateCard" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenantId" UUID NOT NULL,
    "calculationBreakdownId" UUID NOT NULL,
    "rateCardId" UUID NOT NULL,
    "laneId" TEXT NOT NULL,
    "priceBreakId" UUID NOT NULL,
    "priceBreakType" "RateCardPriceBreakType" NOT NULL,
    "rateCardType" "RateCardType" NOT NULL,
    "rateCardBuyId" UUID NOT NULL,

    CONSTRAINT "CalculationBreakdownRateCard_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CalculationBreakdownSurcharge" ADD CONSTRAINT "CalculationBreakdownSurcharge_surchargeId_fkey" FOREIGN KEY ("surchargeId") REFERENCES "Surcharge"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CalculationBreakdownSurcharge" ADD CONSTRAINT "CalculationBreakdownSurcharge_calculationBreakdownId_fkey" FOREIGN KEY ("calculationBreakdownId") REFERENCES "CalculationBreakdown"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CalculationBreakdownFuelLevy" ADD CONSTRAINT "CalculationBreakdownFuelLevy_fuelLevyId_fkey" FOREIGN KEY ("fuelLevyId") REFERENCES "FuelLevy"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CalculationBreakdownFuelLevy" ADD CONSTRAINT "CalculationBreakdownFuelLevy_calculationBreakdownId_fkey" FOREIGN KEY ("calculationBreakdownId") REFERENCES "CalculationBreakdown"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CalculationBreakdownRateCard" ADD CONSTRAINT "CalculationBreakdownRateCard_rateCardId_fkey" FOREIGN KEY ("rateCardId") REFERENCES "RateCard"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CalculationBreakdownRateCard" ADD CONSTRAINT "CalculationBreakdownRateCard_calculationBreakdownId_fkey" FOREIGN KEY ("calculationBreakdownId") REFERENCES "CalculationBreakdown"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
