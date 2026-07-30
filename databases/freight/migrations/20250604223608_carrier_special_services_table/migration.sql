-- CreateTable
CREATE TABLE "SpecialService" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SpecialService_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MasterCarrierServiceSpecialService" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "masterCarrierServiceId" UUID NOT NULL,
    "specialServiceId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MasterCarrierServiceSpecialService_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentDetailSpecialService" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shipmentId" UUID NOT NULL,
    "specialServiceId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ShipmentDetailSpecialService_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "MasterCarrierServiceSpecialService_masterCarrierServiceId_s_key" ON "MasterCarrierServiceSpecialService"("masterCarrierServiceId", "specialServiceId");

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentDetailSpecialService_shipmentId_specialServiceId_key" ON "ShipmentDetailSpecialService"("shipmentId", "specialServiceId");

-- AddForeignKey
ALTER TABLE "MasterCarrierServiceSpecialService" ADD CONSTRAINT "MasterCarrierServiceSpecialService_masterCarrierServiceId_fkey" FOREIGN KEY ("masterCarrierServiceId") REFERENCES "MasterCarrierService"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MasterCarrierServiceSpecialService" ADD CONSTRAINT "MasterCarrierServiceSpecialService_specialServiceId_fkey" FOREIGN KEY ("specialServiceId") REFERENCES "SpecialService"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentDetailSpecialService" ADD CONSTRAINT "ShipmentDetailSpecialService_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "ShipmentDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentDetailSpecialService" ADD CONSTRAINT "ShipmentDetailSpecialService_specialServiceId_fkey" FOREIGN KEY ("specialServiceId") REFERENCES "SpecialService"("id") ON DELETE CASCADE ON UPDATE CASCADE;
