-- CreateEnum
CREATE TYPE "AccountCarrierVisibilityStatus" AS ENUM ('PUBLIC', 'PRIVATE');

-- CreateEnum
CREATE TYPE "AccountCarrierStatus" AS ENUM ('AC_PENDING', 'AC_ACTIVE', 'AC_INACTIVE');

-- CreateEnum
CREATE TYPE "AccountCarrierChargeAccountType" AS ENUM ('TENANT_ACCOUNT', 'CUSTOMER_ACCOUNT', 'SHARED_ACCOUNT');

-- CreateEnum
CREATE TYPE "AccountCarrierServiceStatus" AS ENUM ('ACS_PENDING', 'ACS_ACTIVE', 'ACS_INACTIVE');

-- CreateEnum
CREATE TYPE "CustomerGroupCarrierVisibilityStatus" AS ENUM ('CGC_PUBLIC', 'CGC_PRIVATE');

-- CreateEnum
CREATE TYPE "CustomerGroupCarrierStatus" AS ENUM ('CGC_PENDING', 'CGC_ACTIVE', 'CGC_INACTIVE');

-- CreateEnum
CREATE TYPE "CustomerGroupCarrierChargeAccountType" AS ENUM ('CGC_TENANT_ACCOUNT', 'CGC_CUSTOMER_ACCOUNT', 'CGC_SHARED_ACCOUNT');

-- CreateEnum
CREATE TYPE "CustomerGroupCarrierServiceStatus" AS ENUM ('CGCS_PENDING', 'CGCS_ACTIVE', 'CGCS_INACTIVE');

-- CreateEnum
CREATE TYPE "FuelLevyVersionStatus" AS ENUM ('FUEL_PENDING', 'FUEL_ACTIVE', 'FUEL_INACTIVE');

-- CreateEnum
CREATE TYPE "FuelLevyType" AS ENUM ('FUEL_SELL', 'FUEL_BUY');

-- CreateEnum
CREATE TYPE "FuelLevySellType" AS ENUM ('FUEL_FIXED', 'FUEL_MARKUP');

-- CreateEnum
CREATE TYPE "MasterCarrierStatus" AS ENUM ('PENDING', 'ACTIVE', 'INACTIVE');

-- CreateEnum
CREATE TYPE "MasterCarrierServiceStatus" AS ENUM ('SERVICE_PENDING', 'SERVICE_ACTIVE', 'SERVICE_INACTIVE');

-- CreateEnum
CREATE TYPE "RateCardType" AS ENUM ('RATECARD_SELL', 'RATECARD_BUY');

-- CreateEnum
CREATE TYPE "RateCardStatus" AS ENUM ('RATECARD_ACTIVE', 'RATECARD_INACTIVE');

-- CreateEnum
CREATE TYPE "RateCardPriceBreakType" AS ENUM ('RC_BREAK_KG', 'RC_BREAK_CUBIC', 'RC_BREAK_ITEM', 'RC_BREAK_ITEM_AND_KG', 'RC_BREAK_KG_BASIC', 'PKG', 'M3', 'ITM', 'ARM', 'KG', 'PM3');

-- CreateEnum
CREATE TYPE "RuleType" AS ENUM ('RT_SURCHARGE');

-- CreateEnum
CREATE TYPE "RuleEntity" AS ENUM ('RE_SHIPMENT');

-- CreateEnum
CREATE TYPE "SurchargeSellType" AS ENUM ('SURCHARGE_FIXED', 'SURCHARGE_MARKUP');

-- CreateEnum
CREATE TYPE "SurchargeVersionStatus" AS ENUM ('SURCHARGE_PENDING', 'SURCHARGE_ACTIVE', 'SURCHARGE_INACTIVE');

-- CreateEnum
CREATE TYPE "SurchargeType" AS ENUM ('SURCHARGE_SELL', 'SURCHARGE_BUY');

-- CreateTable
CREATE TABLE "AccountCarrier" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenancyCarrierId" UUID NOT NULL,
    "accountId" UUID NOT NULL,
    "chargeAccountNumber" TEXT,
    "nameTag" TEXT,
    "displayName" TEXT,
    "visibilityStatus" "AccountCarrierVisibilityStatus" NOT NULL,
    "quoteExternally" BOOLEAN NOT NULL DEFAULT false,
    "status" "AccountCarrierStatus" NOT NULL DEFAULT 'AC_PENDING',
    "accountType" "AccountCarrierChargeAccountType",
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "AccountCarrier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AccountCarrierService" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "accountCarrierId" UUID NOT NULL,
    "tenancyCarrierServiceId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "status" "AccountCarrierServiceStatus" NOT NULL DEFAULT 'ACS_PENDING',
    "instructions" TEXT,
    "prefix" TEXT,
    "rangeMin" DOUBLE PRECISION,
    "rangeMax" DOUBLE PRECISION,
    "internalServiceCode" TEXT,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "AccountCarrierService_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CarrierConnectionSchema" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "masterCarrierId" UUID NOT NULL,
    "schema" JSONB NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CarrierConnectionSchema_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CarrierConnection" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "connectionSchemaId" UUID NOT NULL,
    "tenancyCarrierId" UUID,
    "accountCarrierId" UUID,
    "customerGroupCarrierId" UUID,
    "tenantId" UUID NOT NULL,
    "data" JSONB NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CarrierConnection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InternalServiceCode" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "uniqueNumber" SERIAL NOT NULL,
    "serviceCode" TEXT NOT NULL,
    "customerGroupCarrierServiceId" UUID,
    "accountCarrierServiceId" UUID,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "InternalServiceCode_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentMetadata" (
    "shipmentId" UUID NOT NULL,
    "carrier" TEXT NOT NULL,
    "metadata" JSONB NOT NULL,
    "indexIds" TEXT[],
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "ShipmentMetadata_pkey" PRIMARY KEY ("shipmentId")
);

-- CreateTable
CREATE TABLE "CustomerGroupCarrier" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "accountCarrierId" UUID NOT NULL,
    "customerGroupId" UUID NOT NULL,
    "chargeAccountNumber" TEXT,
    "nameTag" TEXT,
    "accountOwner" TEXT,
    "visibilityStatus" "CustomerGroupCarrierVisibilityStatus",
    "quoteExternally" BOOLEAN NOT NULL DEFAULT false,
    "status" "CustomerGroupCarrierStatus" NOT NULL DEFAULT 'CGC_PENDING',
    "chargeAccountType" "CustomerGroupCarrierChargeAccountType",
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "CustomerGroupCarrier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomerGroupCarrierService" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "customerGroupCarrierId" UUID NOT NULL,
    "accountCarrierServiceId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "status" "CustomerGroupCarrierServiceStatus" NOT NULL DEFAULT 'CGCS_PENDING',
    "instructions" TEXT,
    "prefix" TEXT,
    "rangeMin" DOUBLE PRECISION,
    "rangeMax" DOUBLE PRECISION,
    "internalServiceCode" TEXT,
    "shareService" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "CustomerGroupCarrierService_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FuelLevy" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "versionIndex" INTEGER NOT NULL,
    "tenancyCarrierId" UUID,
    "accountCarrierId" UUID,
    "customerGroupCarrierId" UUID,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "FuelLevy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FuelLevyVersion" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "codeIndex" SERIAL NOT NULL,
    "tenancyCarrierId" UUID,
    "accountCarrierId" UUID,
    "customerGroupCarrierId" UUID,
    "rateCardId" UUID,
    "buy" TEXT NOT NULL,
    "sellValue" INTEGER,
    "sellType" "FuelLevySellType",
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "status" "FuelLevyVersionStatus" NOT NULL,
    "type" "FuelLevyType" NOT NULL,
    "notes" TEXT,
    "version" INTEGER NOT NULL,
    "tenantId" UUID NOT NULL,
    "fuelLevyId" UUID NOT NULL,

    CONSTRAINT "FuelLevyVersion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MasterCarrier" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "status" "MasterCarrierStatus" NOT NULL DEFAULT 'PENDING',
    "previousStatus" "MasterCarrierStatus" NOT NULL DEFAULT 'PENDING',
    "notes" TEXT,
    "refShortHand" TEXT,

    CONSTRAINT "MasterCarrier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MasterCarrierContactDetails" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "masterCarrierId" UUID NOT NULL,
    "phone" TEXT,
    "address" TEXT,
    "suburb" TEXT,
    "state" TEXT,
    "postCode" TEXT,

    CONSTRAINT "MasterCarrierContactDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MasterCarrierService" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "masterCarrierId" UUID NOT NULL,
    "service" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "internalServiceCode" TEXT NOT NULL,
    "supplierServiceCode" TEXT NOT NULL,
    "printedConsignmentServiceCode" TEXT NOT NULL,
    "labelServiceCode" TEXT NOT NULL,
    "weightMin" DOUBLE PRECISION,
    "weightMax" DOUBLE PRECISION,
    "volumeMin" DOUBLE PRECISION,
    "volumeMax" DOUBLE PRECISION,
    "defaultCubic" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "status" "MasterCarrierServiceStatus" NOT NULL DEFAULT 'SERVICE_PENDING',

    CONSTRAINT "MasterCarrierService_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MasterCarrierContact" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "masterCarrierId" UUID NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "jobTitle" TEXT,
    "phoneNumber" TEXT,
    "email" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MasterCarrierContact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierOffline" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "address" TEXT,
    "notes" TEXT,
    "sections" JSONB,
    "isStarred" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,

    CONSTRAINT "SupplierOffline_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ServiceDetails" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "area" TEXT,
    "cutOff" TIME,
    "houseAccount" TEXT,
    "phoneNumber" TEXT,
    "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,

    CONSTRAINT "ServiceDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierService" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,
    "serviceDetailsId" UUID NOT NULL,

    CONSTRAINT "SupplierService_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PackageType" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,
    "serviceDetailsId" UUID NOT NULL,

    CONSTRAINT "PackageType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierContact" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT,
    "description" TEXT,
    "phoneNumber" TEXT,
    "email" TEXT,
    "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,

    CONSTRAINT "SupplierContact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierTracking" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "userName" TEXT,
    "site" TEXT,
    "password" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,

    CONSTRAINT "SupplierTracking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Depot" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "address" TEXT,
    "notes" TEXT,
    "sections" JSONB,
    "isStarred" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,

    CONSTRAINT "Depot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DepotDetails" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "area" TEXT,
    "cutOff" TIME,
    "houseAccount" TEXT,
    "phoneNumber" TEXT,
    "createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,
    "depotId" UUID NOT NULL,

    CONSTRAINT "DepotDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DepotService" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,
    "depotDetailsId" UUID NOT NULL,

    CONSTRAINT "DepotService_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DepotPackageType" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,
    "depotDetailsId" UUID NOT NULL,

    CONSTRAINT "DepotPackageType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DepotContact" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT,
    "description" TEXT,
    "phoneNumber" TEXT,
    "email" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,
    "depotId" UUID NOT NULL,

    CONSTRAINT "DepotContact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DepotAttachment" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "fileName" TEXT,
    "reference" TEXT,
    "size" INTEGER,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,
    "depotId" UUID NOT NULL,

    CONSTRAINT "DepotAttachment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SupplierOfflineDepotLink" (
    "supplierId" UUID NOT NULL,
    "depotId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SupplierOfflineDepotLink_pkey" PRIMARY KEY ("supplierId","depotId")
);

-- CreateTable
CREATE TABLE "SupplierAttachment" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "fileName" TEXT,
    "reference" TEXT,
    "size" INTEGER,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,
    "supplierId" UUID NOT NULL,

    CONSTRAINT "SupplierAttachment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MasterCarrierPackageType" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "platformType" TEXT NOT NULL,
    "lengthMin" DOUBLE PRECISION,
    "lengthMax" DOUBLE PRECISION,
    "widthMin" DOUBLE PRECISION,
    "widthMax" DOUBLE PRECISION,
    "heightMin" DOUBLE PRECISION,
    "heightMax" DOUBLE PRECISION,
    "weightMin" DOUBLE PRECISION,
    "weightMax" DOUBLE PRECISION,
    "volumeMin" DOUBLE PRECISION,
    "volumeMax" DOUBLE PRECISION,
    "cubicMin" DOUBLE PRECISION,
    "cubicMax" DOUBLE PRECISION,
    "masterCarrierId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MasterCarrierPackageType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MasterCarrierPlatformPackageType" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MasterCarrierPlatformPackageType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RateCard" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "code" TEXT,
    "codeIndex" SERIAL NOT NULL,
    "type" "RateCardType" NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3),
    "status" "RateCardStatus" NOT NULL,
    "tenantId" UUID NOT NULL,
    "accountId" UUID NOT NULL,
    "tenancyCarrierId" UUID NOT NULL,
    "accountCarrierId" UUID,
    "customerGroupCarrierId" UUID,
    "chargeAccountNumber" TEXT,
    "printTemplateId" TEXT,
    "carrierAccountNumber" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RateCard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RateCardLane" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "service" TEXT NOT NULL,
    "shippingCode" TEXT NOT NULL,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    "isAccumulative" BOOLEAN NOT NULL,
    "isReciprocal" BOOLEAN NOT NULL,
    "cubic" DOUBLE PRECISION NOT NULL,
    "minCharge" DOUBLE PRECISION NOT NULL,
    "cubeLimit" DOUBLE PRECISION NOT NULL,
    "kgLimit" DOUBLE PRECISION NOT NULL,
    "round" DOUBLE PRECISION NOT NULL,
    "tenantId" UUID NOT NULL,
    "rateCardId" UUID NOT NULL,
    "tenacnyCarrierServiceId" UUID NOT NULL,
    "fee" TEXT,
    "fuel" TEXT,

    CONSTRAINT "RateCardLane_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RateCardPriceBreak" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "break" DOUBLE PRECISION NOT NULL,
    "type" "RateCardPriceBreakType" NOT NULL,
    "basic" DOUBLE PRECISION NOT NULL,
    "rate" DOUBLE PRECISION NOT NULL,
    "tenantId" UUID NOT NULL,
    "rateCardLaneId" UUID NOT NULL,

    CONSTRAINT "RateCardPriceBreak_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RateCardAttachedAccount" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "accountId" UUID NOT NULL,
    "rateCardId" UUID NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3),
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RateCardAttachedAccount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Rule" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "type" "RuleType" NOT NULL,
    "entity" "RuleEntity" NOT NULL,
    "data" JSONB NOT NULL,
    "tenantId" UUID NOT NULL,
    "surchargeId" UUID,

    CONSTRAINT "Rule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Surcharge" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "versionIndex" INTEGER NOT NULL,
    "tenancyCarrierId" UUID,
    "accountCarrierId" UUID,
    "customerGroupCarrierId" UUID,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "Surcharge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SurchargeVersion" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "codeIndex" SERIAL NOT NULL,
    "buy" TEXT NOT NULL,
    "sellType" "SurchargeSellType",
    "sellValue" INTEGER,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "status" "SurchargeVersionStatus" NOT NULL,
    "isFuelIncluded" BOOLEAN NOT NULL,
    "isChargeLevyIncluded" BOOLEAN NOT NULL DEFAULT false,
    "type" "SurchargeType" NOT NULL,
    "notes" TEXT,
    "version" INTEGER NOT NULL,
    "tenantId" UUID NOT NULL,
    "surchargeId" UUID NOT NULL,

    CONSTRAINT "SurchargeVersion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TenancyCarrier" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "masterCarrierId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TenancyCarrier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TenancyCarrierService" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenancyCarrierId" UUID NOT NULL,
    "masterCarrierServiceId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TenancyCarrierService_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TenancyCarrierProfile" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenancyCarrierId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "about" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TenancyCarrierProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlatformTrackingEvent" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "PlatformTrackingEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CarrierTrackingEvent" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "carrier" TEXT NOT NULL,
    "platformTrackingEventId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "masterCarrierId" UUID NOT NULL,

    CONSTRAINT "CarrierTrackingEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ZoneETACard" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "displayName" TEXT NOT NULL,
    "start" TIMESTAMP(3) NOT NULL,
    "end" TIMESTAMP(3),
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "masterCarrierId" UUID NOT NULL,
    "masterCarrierServiceId" UUID,

    CONSTRAINT "ZoneETACard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ZoneETA" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "service" TEXT NOT NULL DEFAULT '',
    "fromZone" TEXT NOT NULL,
    "toSuburb" TEXT NOT NULL,
    "toPostcode" TEXT NOT NULL,
    "toState" TEXT NOT NULL,
    "transitTime" INTEGER NOT NULL,
    "country" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "zoneETACardId" UUID NOT NULL,

    CONSTRAINT "ZoneETA_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ZoneCard" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "code" TEXT,
    "codeIndex" SERIAL NOT NULL,
    "start" TIMESTAMP(3) NOT NULL,
    "end" TIMESTAMP(3),
    "displayName" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "masterCarrierId" UUID NOT NULL,
    "masterCarrierServiceId" UUID,

    CONSTRAINT "ZoneCard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Zone" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "suburb" TEXT NOT NULL,
    "postCode" INTEGER NOT NULL,
    "state" TEXT NOT NULL,
    "zone" TEXT NOT NULL,
    "hub" TEXT,
    "parentZone" TEXT,
    "grandParentZone" TEXT,
    "newPostCode" TEXT,
    "service" TEXT,
    "country" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "zoneCardId" UUID NOT NULL,

    CONSTRAINT "Zone_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_FuelLevyToZone" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_FuelLevyToTenancyCarrierService" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_FuelLevyToRateCard" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_RateCardToSurcharge" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_RateCardToRateCardAttachedAccount" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_SurchargeToZone" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_SurchargeToTenancyCarrierService" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "AccountCarrierService_internalServiceCode_key" ON "AccountCarrierService"("internalServiceCode");

-- CreateIndex
CREATE UNIQUE INDEX "AccountCarrierService_accountCarrierId_tenancyCarrierServic_key" ON "AccountCarrierService"("accountCarrierId", "tenancyCarrierServiceId");

-- CreateIndex
CREATE UNIQUE INDEX "CarrierConnectionSchema_masterCarrierId_key" ON "CarrierConnectionSchema"("masterCarrierId");

-- CreateIndex
CREATE UNIQUE INDEX "CarrierConnection_tenancyCarrierId_key" ON "CarrierConnection"("tenancyCarrierId");

-- CreateIndex
CREATE UNIQUE INDEX "CarrierConnection_accountCarrierId_key" ON "CarrierConnection"("accountCarrierId");

-- CreateIndex
CREATE UNIQUE INDEX "CarrierConnection_customerGroupCarrierId_key" ON "CarrierConnection"("customerGroupCarrierId");

-- CreateIndex
CREATE UNIQUE INDEX "InternalServiceCode_customerGroupCarrierServiceId_key" ON "InternalServiceCode"("customerGroupCarrierServiceId");

-- CreateIndex
CREATE UNIQUE INDEX "InternalServiceCode_accountCarrierServiceId_key" ON "InternalServiceCode"("accountCarrierServiceId");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerGroupCarrierService_internalServiceCode_key" ON "CustomerGroupCarrierService"("internalServiceCode");

-- CreateIndex
CREATE UNIQUE INDEX "CustomerGroupCarrierService_customerGroupCarrierId_accountC_key" ON "CustomerGroupCarrierService"("customerGroupCarrierId", "accountCarrierServiceId");

-- CreateIndex
CREATE UNIQUE INDEX "MasterCarrier_name_key" ON "MasterCarrier"("name");

-- CreateIndex
CREATE UNIQUE INDEX "MasterCarrierContactDetails_masterCarrierId_key" ON "MasterCarrierContactDetails"("masterCarrierId");

-- CreateIndex
CREATE UNIQUE INDEX "MasterCarrierService_internalServiceCode_key" ON "MasterCarrierService"("internalServiceCode");

-- CreateIndex
CREATE UNIQUE INDEX "MasterCarrierService_masterCarrierId_service_key" ON "MasterCarrierService"("masterCarrierId", "service");

-- CreateIndex
CREATE UNIQUE INDEX "ServiceDetails_supplierId_key" ON "ServiceDetails"("supplierId");

-- CreateIndex
CREATE UNIQUE INDEX "SupplierTracking_supplierId_key" ON "SupplierTracking"("supplierId");

-- CreateIndex
CREATE UNIQUE INDEX "DepotDetails_depotId_key" ON "DepotDetails"("depotId");

-- CreateIndex
CREATE UNIQUE INDEX "TenancyCarrier_masterCarrierId_tenantId_key" ON "TenancyCarrier"("masterCarrierId", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "TenancyCarrierService_tenancyCarrierId_masterCarrierService_key" ON "TenancyCarrierService"("tenancyCarrierId", "masterCarrierServiceId");

-- CreateIndex
CREATE UNIQUE INDEX "TenancyCarrierProfile_tenantId_tenancyCarrierId_key" ON "TenancyCarrierProfile"("tenantId", "tenancyCarrierId");

-- CreateIndex
CREATE UNIQUE INDEX "PlatformTrackingEvent_name_key" ON "PlatformTrackingEvent"("name");

-- CreateIndex
CREATE UNIQUE INDEX "CarrierTrackingEvent_carrier_name_key" ON "CarrierTrackingEvent"("carrier", "name");

-- CreateIndex
CREATE UNIQUE INDEX "_FuelLevyToZone_AB_unique" ON "_FuelLevyToZone"("A", "B");

-- CreateIndex
CREATE INDEX "_FuelLevyToZone_B_index" ON "_FuelLevyToZone"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_FuelLevyToTenancyCarrierService_AB_unique" ON "_FuelLevyToTenancyCarrierService"("A", "B");

-- CreateIndex
CREATE INDEX "_FuelLevyToTenancyCarrierService_B_index" ON "_FuelLevyToTenancyCarrierService"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_FuelLevyToRateCard_AB_unique" ON "_FuelLevyToRateCard"("A", "B");

-- CreateIndex
CREATE INDEX "_FuelLevyToRateCard_B_index" ON "_FuelLevyToRateCard"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_RateCardToSurcharge_AB_unique" ON "_RateCardToSurcharge"("A", "B");

-- CreateIndex
CREATE INDEX "_RateCardToSurcharge_B_index" ON "_RateCardToSurcharge"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_RateCardToRateCardAttachedAccount_AB_unique" ON "_RateCardToRateCardAttachedAccount"("A", "B");

-- CreateIndex
CREATE INDEX "_RateCardToRateCardAttachedAccount_B_index" ON "_RateCardToRateCardAttachedAccount"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_SurchargeToZone_AB_unique" ON "_SurchargeToZone"("A", "B");

-- CreateIndex
CREATE INDEX "_SurchargeToZone_B_index" ON "_SurchargeToZone"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_SurchargeToTenancyCarrierService_AB_unique" ON "_SurchargeToTenancyCarrierService"("A", "B");

-- CreateIndex
CREATE INDEX "_SurchargeToTenancyCarrierService_B_index" ON "_SurchargeToTenancyCarrierService"("B");

-- AddForeignKey
ALTER TABLE "AccountCarrier" ADD CONSTRAINT "AccountCarrier_tenancyCarrierId_fkey" FOREIGN KEY ("tenancyCarrierId") REFERENCES "TenancyCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AccountCarrierService" ADD CONSTRAINT "AccountCarrierService_accountCarrierId_fkey" FOREIGN KEY ("accountCarrierId") REFERENCES "AccountCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AccountCarrierService" ADD CONSTRAINT "AccountCarrierService_tenancyCarrierServiceId_fkey" FOREIGN KEY ("tenancyCarrierServiceId") REFERENCES "TenancyCarrierService"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierConnectionSchema" ADD CONSTRAINT "CarrierConnectionSchema_masterCarrierId_fkey" FOREIGN KEY ("masterCarrierId") REFERENCES "MasterCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierConnection" ADD CONSTRAINT "CarrierConnection_accountCarrierId_fkey" FOREIGN KEY ("accountCarrierId") REFERENCES "AccountCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierConnection" ADD CONSTRAINT "CarrierConnection_connectionSchemaId_fkey" FOREIGN KEY ("connectionSchemaId") REFERENCES "CarrierConnectionSchema"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierConnection" ADD CONSTRAINT "CarrierConnection_customerGroupCarrierId_fkey" FOREIGN KEY ("customerGroupCarrierId") REFERENCES "CustomerGroupCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierConnection" ADD CONSTRAINT "CarrierConnection_tenancyCarrierId_fkey" FOREIGN KEY ("tenancyCarrierId") REFERENCES "TenancyCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerGroupCarrier" ADD CONSTRAINT "CustomerGroupCarrier_accountCarrierId_fkey" FOREIGN KEY ("accountCarrierId") REFERENCES "AccountCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerGroupCarrierService" ADD CONSTRAINT "CustomerGroupCarrierService_accountCarrierServiceId_fkey" FOREIGN KEY ("accountCarrierServiceId") REFERENCES "AccountCarrierService"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerGroupCarrierService" ADD CONSTRAINT "CustomerGroupCarrierService_customerGroupCarrierId_fkey" FOREIGN KEY ("customerGroupCarrierId") REFERENCES "CustomerGroupCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FuelLevyVersion" ADD CONSTRAINT "FuelLevyVersion_fuelLevyId_fkey" FOREIGN KEY ("fuelLevyId") REFERENCES "FuelLevy"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MasterCarrierContactDetails" ADD CONSTRAINT "MasterCarrierContactDetails_masterCarrierId_fkey" FOREIGN KEY ("masterCarrierId") REFERENCES "MasterCarrier"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MasterCarrierService" ADD CONSTRAINT "MasterCarrierService_masterCarrierId_fkey" FOREIGN KEY ("masterCarrierId") REFERENCES "MasterCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MasterCarrierContact" ADD CONSTRAINT "MasterCarrierContact_masterCarrierId_fkey" FOREIGN KEY ("masterCarrierId") REFERENCES "MasterCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServiceDetails" ADD CONSTRAINT "ServiceDetails_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "SupplierOffline"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierService" ADD CONSTRAINT "SupplierService_serviceDetailsId_fkey" FOREIGN KEY ("serviceDetailsId") REFERENCES "ServiceDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PackageType" ADD CONSTRAINT "PackageType_serviceDetailsId_fkey" FOREIGN KEY ("serviceDetailsId") REFERENCES "ServiceDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierContact" ADD CONSTRAINT "SupplierContact_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "SupplierOffline"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierTracking" ADD CONSTRAINT "SupplierTracking_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "SupplierOffline"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DepotDetails" ADD CONSTRAINT "DepotDetails_depotId_fkey" FOREIGN KEY ("depotId") REFERENCES "Depot"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DepotService" ADD CONSTRAINT "DepotService_depotDetailsId_fkey" FOREIGN KEY ("depotDetailsId") REFERENCES "DepotDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DepotPackageType" ADD CONSTRAINT "DepotPackageType_depotDetailsId_fkey" FOREIGN KEY ("depotDetailsId") REFERENCES "DepotDetails"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DepotContact" ADD CONSTRAINT "DepotContact_depotId_fkey" FOREIGN KEY ("depotId") REFERENCES "Depot"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DepotAttachment" ADD CONSTRAINT "DepotAttachment_depotId_fkey" FOREIGN KEY ("depotId") REFERENCES "Depot"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierOfflineDepotLink" ADD CONSTRAINT "SupplierOfflineDepotLink_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "SupplierOffline"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierOfflineDepotLink" ADD CONSTRAINT "SupplierOfflineDepotLink_depotId_fkey" FOREIGN KEY ("depotId") REFERENCES "Depot"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SupplierAttachment" ADD CONSTRAINT "SupplierAttachment_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "SupplierOffline"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MasterCarrierPackageType" ADD CONSTRAINT "MasterCarrierPackageType_masterCarrierId_fkey" FOREIGN KEY ("masterCarrierId") REFERENCES "MasterCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RateCard" ADD CONSTRAINT "RateCard_tenancyCarrierId_fkey" FOREIGN KEY ("tenancyCarrierId") REFERENCES "TenancyCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RateCardLane" ADD CONSTRAINT "RateCardLane_rateCardId_fkey" FOREIGN KEY ("rateCardId") REFERENCES "RateCard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RateCardPriceBreak" ADD CONSTRAINT "RateCardPriceBreak_rateCardLaneId_fkey" FOREIGN KEY ("rateCardLaneId") REFERENCES "RateCardLane"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rule" ADD CONSTRAINT "Rule_surchargeId_fkey" FOREIGN KEY ("surchargeId") REFERENCES "Surcharge"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SurchargeVersion" ADD CONSTRAINT "SurchargeVersion_surchargeId_fkey" FOREIGN KEY ("surchargeId") REFERENCES "Surcharge"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TenancyCarrier" ADD CONSTRAINT "TenancyCarrier_masterCarrierId_fkey" FOREIGN KEY ("masterCarrierId") REFERENCES "MasterCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TenancyCarrierService" ADD CONSTRAINT "TenancyCarrierService_masterCarrierServiceId_fkey" FOREIGN KEY ("masterCarrierServiceId") REFERENCES "MasterCarrierService"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TenancyCarrierService" ADD CONSTRAINT "TenancyCarrierService_tenancyCarrierId_fkey" FOREIGN KEY ("tenancyCarrierId") REFERENCES "TenancyCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TenancyCarrierProfile" ADD CONSTRAINT "TenancyCarrierProfile_tenancyCarrierId_fkey" FOREIGN KEY ("tenancyCarrierId") REFERENCES "TenancyCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CarrierTrackingEvent" ADD CONSTRAINT "CarrierTrackingEvent_platformTrackingEventId_fkey" FOREIGN KEY ("platformTrackingEventId") REFERENCES "PlatformTrackingEvent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ZoneETACard" ADD CONSTRAINT "ZoneETACard_masterCarrierId_fkey" FOREIGN KEY ("masterCarrierId") REFERENCES "MasterCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ZoneETA" ADD CONSTRAINT "ZoneETA_zoneETACardId_fkey" FOREIGN KEY ("zoneETACardId") REFERENCES "ZoneETACard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ZoneCard" ADD CONSTRAINT "ZoneCard_masterCarrierId_fkey" FOREIGN KEY ("masterCarrierId") REFERENCES "MasterCarrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Zone" ADD CONSTRAINT "Zone_zoneCardId_fkey" FOREIGN KEY ("zoneCardId") REFERENCES "ZoneCard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FuelLevyToZone" ADD CONSTRAINT "_FuelLevyToZone_A_fkey" FOREIGN KEY ("A") REFERENCES "FuelLevy"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FuelLevyToZone" ADD CONSTRAINT "_FuelLevyToZone_B_fkey" FOREIGN KEY ("B") REFERENCES "Zone"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FuelLevyToTenancyCarrierService" ADD CONSTRAINT "_FuelLevyToTenancyCarrierService_A_fkey" FOREIGN KEY ("A") REFERENCES "FuelLevy"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FuelLevyToTenancyCarrierService" ADD CONSTRAINT "_FuelLevyToTenancyCarrierService_B_fkey" FOREIGN KEY ("B") REFERENCES "TenancyCarrierService"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FuelLevyToRateCard" ADD CONSTRAINT "_FuelLevyToRateCard_A_fkey" FOREIGN KEY ("A") REFERENCES "FuelLevy"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FuelLevyToRateCard" ADD CONSTRAINT "_FuelLevyToRateCard_B_fkey" FOREIGN KEY ("B") REFERENCES "RateCard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RateCardToSurcharge" ADD CONSTRAINT "_RateCardToSurcharge_A_fkey" FOREIGN KEY ("A") REFERENCES "RateCard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RateCardToSurcharge" ADD CONSTRAINT "_RateCardToSurcharge_B_fkey" FOREIGN KEY ("B") REFERENCES "Surcharge"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RateCardToRateCardAttachedAccount" ADD CONSTRAINT "_RateCardToRateCardAttachedAccount_A_fkey" FOREIGN KEY ("A") REFERENCES "RateCard"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RateCardToRateCardAttachedAccount" ADD CONSTRAINT "_RateCardToRateCardAttachedAccount_B_fkey" FOREIGN KEY ("B") REFERENCES "RateCardAttachedAccount"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SurchargeToZone" ADD CONSTRAINT "_SurchargeToZone_A_fkey" FOREIGN KEY ("A") REFERENCES "Surcharge"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SurchargeToZone" ADD CONSTRAINT "_SurchargeToZone_B_fkey" FOREIGN KEY ("B") REFERENCES "Zone"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SurchargeToTenancyCarrierService" ADD CONSTRAINT "_SurchargeToTenancyCarrierService_A_fkey" FOREIGN KEY ("A") REFERENCES "Surcharge"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_SurchargeToTenancyCarrierService" ADD CONSTRAINT "_SurchargeToTenancyCarrierService_B_fkey" FOREIGN KEY ("B") REFERENCES "TenancyCarrierService"("id") ON DELETE CASCADE ON UPDATE CASCADE;
