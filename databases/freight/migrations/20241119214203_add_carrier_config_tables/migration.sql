-- CreateTable
CREATE TABLE "AccountCarrierConfig" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "accountCarrierId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "consignmentPrefix" TEXT,
    "consignmentMax" INTEGER,
    "consignmentMin" INTEGER,
    "consignmentNextId" INTEGER,
    "manifestPrefix" TEXT,
    "manifestMax" INTEGER,
    "manifestMin" INTEGER,
    "manifestNextId" INTEGER,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AccountCarrierConfig_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomerGroupCarrierConfig" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "customerGroupCarrierId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "consignmentPrefix" TEXT,
    "consignmentMax" INTEGER,
    "consignmentMin" INTEGER,
    "consignmentNextId" INTEGER,
    "manifestPrefix" TEXT,
    "manifestMax" INTEGER,
    "manifestMin" INTEGER,
    "manifestNextId" INTEGER,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CustomerGroupCarrierConfig_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MasterCarrierConfig" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "masterCarrierId" UUID NOT NULL,
    "consignmentPrefix" TEXT,
    "consignmentLength" INTEGER,
    "consignmentPrefixRequired" BOOLEAN,
    "manifestPrefix" TEXT,
    "manifestLength" INTEGER,
    "manifestPrefixRequired" BOOLEAN,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MasterCarrierConfig_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TenancyCarrierConfig" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenancyCarrierId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "consignmentMax" INTEGER,
    "manifestMax" INTEGER,
    "consignmentMin" INTEGER,
    "manifestMin" INTEGER,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TenancyCarrierConfig_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "AccountCarrierConfig_accountCarrierId_key" ON "AccountCarrierConfig"("accountCarrierId");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerGroupCarrierConfig_customerGroupCarrierId_key" ON "CustomerGroupCarrierConfig"("customerGroupCarrierId");

-- CreateIndex
CREATE UNIQUE INDEX "MasterCarrierConfig_masterCarrierId_key" ON "MasterCarrierConfig"("masterCarrierId");

-- CreateIndex
CREATE UNIQUE INDEX "TenancyCarrierConfig_tenancyCarrierId_key" ON "TenancyCarrierConfig"("tenancyCarrierId");

-- AddForeignKey
ALTER TABLE "AccountCarrierConfig" ADD CONSTRAINT "AccountCarrierConfig_accountCarrierId_fkey" FOREIGN KEY ("accountCarrierId") REFERENCES "AccountCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerGroupCarrierConfig" ADD CONSTRAINT "CustomerGroupCarrierConfig_customerGroupCarrierId_fkey" FOREIGN KEY ("customerGroupCarrierId") REFERENCES "CustomerGroupCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MasterCarrierConfig" ADD CONSTRAINT "MasterCarrierConfig_masterCarrierId_fkey" FOREIGN KEY ("masterCarrierId") REFERENCES "MasterCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TenancyCarrierConfig" ADD CONSTRAINT "TenancyCarrierConfig_tenancyCarrierId_fkey" FOREIGN KEY ("tenancyCarrierId") REFERENCES "TenancyCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;
