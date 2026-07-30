-- CreateTable
CREATE TABLE "CarrierPickupConfig" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "masterCarrierId" UUID NOT NULL,
    "cutOffTime" TEXT,
    "timezone" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CarrierPickupConfig_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CarrierPickupConfig_masterCarrierId_key" ON "CarrierPickupConfig"("masterCarrierId");

-- AddForeignKey
ALTER TABLE "CarrierPickupConfig" ADD CONSTRAINT "CarrierPickupConfig_masterCarrierId_fkey" FOREIGN KEY ("masterCarrierId") REFERENCES "MasterCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;
