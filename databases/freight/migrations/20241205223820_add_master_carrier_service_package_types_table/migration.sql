-- CreateTable
CREATE TABLE "MasterCarrierServicePackageType" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "masterCarrierServiceId" UUID NOT NULL,
    "masterCarrierPackageTypeId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MasterCarrierServicePackageType_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "MasterCarrierServicePackageType" ADD CONSTRAINT "MasterCarrierServicePackageType_masterCarrierServiceId_fkey" FOREIGN KEY ("masterCarrierServiceId") REFERENCES "MasterCarrierService"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MasterCarrierServicePackageType" ADD CONSTRAINT "MasterCarrierServicePackageType_masterCarrierPackageTypeId_fkey" FOREIGN KEY ("masterCarrierPackageTypeId") REFERENCES "MasterCarrierPackageType"("id") ON DELETE CASCADE ON UPDATE CASCADE;

/*
  Warnings:

  - A unique constraint covering the columns `[masterCarrierServiceId,masterCarrierPackageTypeId]` on the table `MasterCarrierServicePackageType` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "MasterCarrierServicePackageType_masterCarrierServiceId_mast_key" ON "MasterCarrierServicePackageType"("masterCarrierServiceId", "masterCarrierPackageTypeId");
