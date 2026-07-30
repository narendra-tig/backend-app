-- CreateTable
CREATE TABLE "OfCarrierReference" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "masterCarrierId" UUID NOT NULL,
    "ofCarrierReferenceId" TEXT NOT NULL,

    CONSTRAINT "OfCarrierReference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OfCarrierServiceReference" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "masterCarrierServiceId" UUID NOT NULL,
    "ofServiceReferenceId" TEXT NOT NULL,

    CONSTRAINT "OfCarrierServiceReference_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "OfCarrierReference_masterCarrierId_key" ON "OfCarrierReference"("masterCarrierId");

-- CreateIndex
CREATE UNIQUE INDEX "OfCarrierReference_masterCarrierId_ofCarrierReferenceId_key" ON "OfCarrierReference"("masterCarrierId", "ofCarrierReferenceId");

-- CreateIndex
CREATE UNIQUE INDEX "OfCarrierServiceReference_masterCarrierServiceId_key" ON "OfCarrierServiceReference"("masterCarrierServiceId");

-- CreateIndex
CREATE UNIQUE INDEX "OfCarrierServiceReference_masterCarrierServiceId_ofServiceR_key" ON "OfCarrierServiceReference"("masterCarrierServiceId", "ofServiceReferenceId");

-- AddForeignKey
ALTER TABLE "OfCarrierReference" ADD CONSTRAINT "OfCarrierReference_masterCarrierId_fkey" FOREIGN KEY ("masterCarrierId") REFERENCES "MasterCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OfCarrierServiceReference" ADD CONSTRAINT "OfCarrierServiceReference_masterCarrierServiceId_fkey" FOREIGN KEY ("masterCarrierServiceId") REFERENCES "MasterCarrierService"("id") ON DELETE CASCADE ON UPDATE CASCADE;
