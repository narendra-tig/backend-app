-- CreateEnum
CREATE TYPE "RangeStatus" AS ENUM ('RS_ACTIVE', 'RS_DEPLETED');

-- CreateEnum
CREATE TYPE "RangeType" AS ENUM ('RT_SHIPMENT', 'RT_MANIFEST');

-- CreateTable
CREATE TABLE "RangeManagementId" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "startId" INTEGER NOT NULL,
    "currentId" INTEGER NOT NULL,
    "endId" INTEGER NOT NULL,
    "status" "RangeStatus" NOT NULL,
    "type" "RangeType" NOT NULL,
    "tenantId" UUID NOT NULL,
    "carrierConfigId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RangeManagementId_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "RangeManagementId_carrierConfigId_type_key" ON "RangeManagementId"("carrierConfigId", "type");
