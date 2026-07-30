/*
  Warnings:

  - A unique constraint covering the columns `[newShipmentId]` on the table `PalletsManagement` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `serviceType` to the `SpecialService` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tenantId` to the `SpecialService` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "TradeDirection" AS ENUM ('EXPORT', 'IMPORT', 'DOMESTIC');

-- CreateEnum
CREATE TYPE "ShipmentLegMode" AS ENUM ('FIRST_MILE', 'LINEHAUL', 'LAST_MILE', 'AIR', 'SEA', 'RAIL');

-- CreateEnum
CREATE TYPE "LegEventType" AS ENUM ('PICKED_UP', 'IN_TRANSIT', 'AT_DEPOT', 'OUT_FOR_DELIVERY', 'DELIVERED', 'EXCEPTION');

-- CreateEnum
CREATE TYPE "AttachmentType" AS ENUM ('LABEL', 'INVOICE', 'POD', 'PICKUP_CONFIRMATION', 'CUSTOMS_DECLARATION', 'COMMERCIAL_INVOICE', 'OTHER');

-- CreateEnum
CREATE TYPE "AddressValidationStatus" AS ENUM ('VALID', 'INVALID', 'UNVALIDATED', 'PARTIAL');

-- CreateEnum
CREATE TYPE "AddressValidationLevel" AS ENUM ('ADDRESS', 'SUBURB', 'POSTCODE', 'STATE', 'COUNTRY');

-- CreateEnum
CREATE TYPE "NotificationChannel" AS ENUM ('EMAIL', 'SMS', 'WEBHOOK', 'PUSH');

-- CreateEnum
CREATE TYPE "NotificationStatus" AS ENUM ('PENDING', 'SENT', 'DELIVERED', 'FAILED', 'BOUNCED');

-- CreateEnum
CREATE TYPE "PricingType" AS ENUM ('QUOTED', 'ACCEPTED', 'BILLED', 'ESTIMATED');

-- CreateEnum
CREATE TYPE "LocationType" AS ENUM ('RESIDENTIAL', 'BUSINESS', 'DEPOT', 'WAREHOUSE', 'PO_BOX');

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "ShipmentStatus" ADD VALUE 'IN_TRANSIT';
ALTER TYPE "ShipmentStatus" ADD VALUE 'UPDATED';
ALTER TYPE "ShipmentStatus" ADD VALUE 'CREATED';

-- DropForeignKey
ALTER TABLE "public"."ShipmentDetailSpecialService" DROP CONSTRAINT "ShipmentDetailSpecialService_shipmentId_fkey";

-- DropForeignKey
ALTER TABLE "public"."ShipmentDetailSpecialService" DROP CONSTRAINT "ShipmentDetailSpecialService_specialServiceId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Watchlist" DROP CONSTRAINT "Watchlist_shipmentId_fkey";

-- AlterTable
ALTER TABLE "Address" ADD COLUMN     "locationType" "LocationType" DEFAULT 'BUSINESS',
ADD COLUMN     "zoneCardZoneId" UUID;

-- AlterTable
ALTER TABLE "Package" ADD COLUMN     "barcode" TEXT,
ADD COLUMN     "newShipmentId" UUID,
ADD COLUMN     "number" TEXT,
ALTER COLUMN "shipmentId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "PackageContents" ADD COLUMN     "contentType" TEXT,
ADD COLUMN     "value" DECIMAL(65,30);

-- AlterTable
ALTER TABLE "PalletsManagement" ADD COLUMN     "chepAccountNumber" TEXT,
ADD COLUMN     "chepIn" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "chepOut" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "loscamAccountNumber" TEXT,
ADD COLUMN     "loscamIn" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "loscamOut" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "newShipmentId" UUID,
ADD COLUMN     "otherIn" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "otherOut" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "otherPalletDetails" TEXT,
ALTER COLUMN "shipmentId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Paperwork" ADD COLUMN     "newShipmentId" UUID,
ALTER COLUMN "shipmentId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "ShipmentDetailSpecialService" ADD COLUMN     "shipmentDetailsId" UUID;

-- AlterTable
ALTER TABLE "SpecialService" ADD COLUMN     "details" TEXT,
ADD COLUMN     "serviceType" TEXT,
ADD COLUMN     "tenantId" UUID;

-- AlterTable
ALTER TABLE "Watchlist" ADD COLUMN     "newShipmentId" UUID,
ALTER COLUMN "shipmentId" DROP NOT NULL;

-- Enable Row Level Security on Watchlist table
ALTER TABLE "Watchlist" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Watchlist" FORCE ROW LEVEL SECURITY;

-- Create tenant isolation policy for Watchlist
CREATE POLICY tenant_isolation_policy ON "Watchlist" 
  USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) 
  WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);

-- Create bypass RLS policy for Watchlist
CREATE POLICY bypass_rls_policy ON "Watchlist" 
  USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

-- Add primary keys to implicit many-to-many relations if they don't exist
-- These replace the unique indexes with proper primary keys

-- _FuelLevyToRateCard
DO $$ BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = '_FuelLevyToRateCard_AB_pkey'
    ) THEN
        ALTER TABLE "_FuelLevyToRateCard" ADD CONSTRAINT "_FuelLevyToRateCard_AB_pkey" PRIMARY KEY ("A", "B");
    END IF;
END $$;

DROP INDEX IF EXISTS "public"."_FuelLevyToRateCard_AB_unique";

-- _FuelLevyToTenancyCarrierService
DO $$ BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = '_FuelLevyToTenancyCarrierService_AB_pkey'
    ) THEN
        ALTER TABLE "_FuelLevyToTenancyCarrierService" ADD CONSTRAINT "_FuelLevyToTenancyCarrierService_AB_pkey" PRIMARY KEY ("A", "B");
    END IF;
END $$;

DROP INDEX IF EXISTS "public"."_FuelLevyToTenancyCarrierService_AB_unique";

-- _FuelLevyToZone
DO $$ BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = '_FuelLevyToZone_AB_pkey'
    ) THEN
        ALTER TABLE "_FuelLevyToZone" ADD CONSTRAINT "_FuelLevyToZone_AB_pkey" PRIMARY KEY ("A", "B");
    END IF;
END $$;

DROP INDEX IF EXISTS "public"."_FuelLevyToZone_AB_unique";

-- _RateCardToRateCardAttachedAccount
DO $$ BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = '_RateCardToRateCardAttachedAccount_AB_pkey'
    ) THEN
        ALTER TABLE "_RateCardToRateCardAttachedAccount" ADD CONSTRAINT "_RateCardToRateCardAttachedAccount_AB_pkey" PRIMARY KEY ("A", "B");
    END IF;
END $$;

DROP INDEX IF EXISTS "public"."_RateCardToRateCardAttachedAccount_AB_unique";

-- _RateCardToSurcharge
DO $$ BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = '_RateCardToSurcharge_AB_pkey'
    ) THEN
        ALTER TABLE "_RateCardToSurcharge" ADD CONSTRAINT "_RateCardToSurcharge_AB_pkey" PRIMARY KEY ("A", "B");
    END IF;
END $$;

DROP INDEX IF EXISTS "public"."_RateCardToSurcharge_AB_unique";

-- _RuleToSurcharge
DO $$ BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = '_RuleToSurcharge_AB_pkey'
    ) THEN
        ALTER TABLE "_RuleToSurcharge" ADD CONSTRAINT "_RuleToSurcharge_AB_pkey" PRIMARY KEY ("A", "B");
    END IF;
END $$;

DROP INDEX IF EXISTS "public"."_RuleToSurcharge_AB_unique";

-- _SurchargeToTenancyCarrierService
DO $$ BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = '_SurchargeToTenancyCarrierService_AB_pkey'
    ) THEN
        ALTER TABLE "_SurchargeToTenancyCarrierService" ADD CONSTRAINT "_SurchargeToTenancyCarrierService_AB_pkey" PRIMARY KEY ("A", "B");
    END IF;
END $$;

DROP INDEX IF EXISTS "public"."_SurchargeToTenancyCarrierService_AB_unique";

-- _SurchargeToZone
DO $$ BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = '_SurchargeToZone_AB_pkey'
    ) THEN
        ALTER TABLE "_SurchargeToZone" ADD CONSTRAINT "_SurchargeToZone_AB_pkey" PRIMARY KEY ("A", "B");
    END IF;
END $$;

DROP INDEX IF EXISTS "public"."_SurchargeToZone_AB_unique";

-- CreateTable
CREATE TABLE "DangerousGoods" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "contentId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "dgClass" TEXT NOT NULL,
    "subRiskClass" TEXT,
    "unNumber" INTEGER NOT NULL,
    "properShippingName" TEXT NOT NULL,
    "technicalName" TEXT,
    "packingGroup" TEXT,
    "packagingInstruction" TEXT,
    "hazardLabels" TEXT[],
    "isLimitedQuantity" BOOLEAN NOT NULL DEFAULT false,
    "limitedQuantityValue" TEXT,
    "marinePollutant" BOOLEAN NOT NULL DEFAULT false,
    "emergencyContact" TEXT,
    "emergencyContactName" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DangerousGoods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentInternational" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shipmentId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "isInternational" BOOLEAN NOT NULL DEFAULT true,
    "tradeDirection" "TradeDirection" NOT NULL,
    "exportCountry" TEXT,
    "importCountry" TEXT,
    "incoterm" TEXT,
    "customsValue" DECIMAL(65,30),
    "customsCurrency" TEXT DEFAULT 'AUD',
    "commercialInvoiceNumber" TEXT,
    "commercialInvoiceDate" DATE,
    "exportDeclarationNumber" TEXT,
    "preferentialOriginStatement" TEXT,
    "exporterName" TEXT,
    "exporterRegistrationNumber" TEXT,
    "exporterTaxId" TEXT,
    "exporterCountry" TEXT,
    "importerName" TEXT,
    "importerRegistrationNumber" TEXT,
    "importerTaxId" TEXT,
    "importerCountry" TEXT,
    "customsBrokerName" TEXT,
    "customsBrokerReference" TEXT,
    "customsBrokerContact" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ShipmentInternational_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PackageInternational" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "packageId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "exportDeclarationNumber" TEXT,
    "value" DECIMAL(65,30),
    "valueCurrency" TEXT DEFAULT 'AUD',
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PackageInternational_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ContentInternational" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "contentId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "exportDescription" TEXT,
    "exportHsCode" TEXT,
    "exportOriginCountry" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ContentInternational_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentLeg" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shipmentId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "fromLocationId" UUID,
    "toLocationId" UUID,
    "mode" "ShipmentLegMode" NOT NULL,
    "sequenceNumber" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "newShipmentId" UUID,

    CONSTRAINT "ShipmentLeg_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LegEvent" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "legId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "locationId" UUID,
    "eventType" "LegEventType" NOT NULL,
    "eventTime" TIMESTAMPTZ NOT NULL,
    "notes" TEXT,
    "misc" JSONB,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LegEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentAttachment" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shipmentId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "type" "AttachmentType" NOT NULL,
    "filename" TEXT NOT NULL,
    "mimeType" TEXT,
    "size" BIGINT,
    "storageReference" TEXT NOT NULL,
    "uploadedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "uploadedBy" UUID,

    CONSTRAINT "ShipmentAttachment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AddressValidation" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "addressId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "status" "AddressValidationStatus" NOT NULL DEFAULT 'UNVALIDATED',
    "level" "AddressValidationLevel",
    "source" TEXT,
    "sourceReference" TEXT,
    "errors" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "validatedAt" TIMESTAMPTZ,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AddressValidation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentAttribute" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shipmentId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "type" TEXT NOT NULL DEFAULT 'string',
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ShipmentAttribute_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentIntegration" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shipmentId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "carrierRateCalculation" JSONB,
    "carrierBookingRequest" JSONB,
    "carrierBookingResponse" JSONB,
    "carrierTrackingData" JSONB,
    "misc" JSONB,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ShipmentIntegration_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentNotification" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shipmentId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "channel" "NotificationChannel" NOT NULL,
    "provider" TEXT,
    "providerEventId" TEXT,
    "providerMessageId" TEXT,
    "templateId" TEXT,
    "recipient" TEXT NOT NULL,
    "status" "NotificationStatus" NOT NULL,
    "sentAt" TIMESTAMPTZ,
    "deliveredAt" TIMESTAMPTZ,
    "failedAt" TIMESTAMPTZ,
    "error" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ShipmentNotification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentMeta" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shipmentId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "schemaVersion" TEXT,
    "sourceSystem" TEXT,
    "sourceChannel" TEXT,
    "idempotencyKey" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ShipmentMeta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentStatusHistory" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shipmentId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "status" "ShipmentStatus" NOT NULL,
    "changedAt" TIMESTAMPTZ NOT NULL,
    "changedBy" TEXT,
    "notes" TEXT,
    "misc" JSONB,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ShipmentStatusHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentPricing" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shipmentId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "configuredSupplierServiceId" UUID,
    "type" "PricingType" NOT NULL,
    "baseCost" MONEY NOT NULL,
    "fuelTotal" MONEY NOT NULL DEFAULT 0,
    "surchargeTotal" MONEY NOT NULL DEFAULT 0,
    "taxTotal" MONEY NOT NULL DEFAULT 0,
    "totalCost" MONEY NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "newShipmentId" UUID,

    CONSTRAINT "ShipmentPricing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingSurcharge" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "pricingId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "code" TEXT NOT NULL,
    "amount" MONEY NOT NULL,
    "packageId" UUID,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PricingSurcharge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NewShipment" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "reference" TEXT,
    "senderId" UUID NOT NULL,
    "receiverId" UUID NOT NULL,
    "dispatchDate" TIMESTAMPTZ NOT NULL,
    "signaturePreference" "SignaturePreference" NOT NULL,
    "billTo" TEXT NOT NULL,
    "carrier" TEXT NOT NULL,
    "serviceName" TEXT NOT NULL DEFAULT '',
    "serviceId" UUID NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000'::uuid,
    "connectionId" UUID NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000'::uuid,
    "pickupInstructions" TEXT,
    "deliveryInstructions" TEXT,
    "customReference" TEXT,
    "status" "ShipmentStatus" NOT NULL,
    "pickupId" UUID,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "accountId" UUID NOT NULL,
    "customerGroupId" UUID NOT NULL,
    "shipmentReferenceId" TEXT,
    "minBusinessDays" INTEGER,
    "maxBusinessDays" INTEGER,
    "estimatedPrice" MONEY,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted" BOOLEAN NOT NULL DEFAULT false,
    "manifestId" UUID,
    "consignmentReference" TEXT,
    "internalReference" TEXT,
    "returnCode" TEXT,
    "customerReference" TEXT,
    "supplierReference" TEXT,
    "configuredSupplierServiceId" UUID,
    "trackingNumber" TEXT,
    "handlingInstructions" TEXT,
    "billToName" TEXT,
    "billToCustomerGroupId" UUID,
    "thirdPartyAccountNumber" TEXT,
    "shipmentDetailsId" UUID,
    "shipmentTrackingId" UUID,
    "createdBy" UUID,

    CONSTRAINT "NewShipment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentTracking" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shipmentId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "status" TEXT,
    "minEta" TIMESTAMPTZ,
    "minEtt" INTEGER,
    "maxEta" TIMESTAMPTZ,
    "maxEtt" INTEGER,
    "avgEta" TIMESTAMPTZ,
    "avgEtt" INTEGER,
    "timeEstimates" JSONB,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ShipmentTracking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TrackingTimeslot" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "trackingId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "startTime" TIMESTAMPTZ NOT NULL,
    "endTime" TIMESTAMPTZ NOT NULL,
    "type" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TrackingTimeslot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TrackingEvent" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "trackingId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "trackingNumber" TEXT NOT NULL,
    "carrierCode" TEXT,
    "locationSuburb" TEXT,
    "locationState" TEXT,
    "locationPostcode" TEXT,
    "locationCountry" TEXT,
    "eventCode" TEXT NOT NULL,
    "eventDescription" TEXT NOT NULL,
    "signedBy" TEXT,
    "fileId" UUID,
    "eventTime" TIMESTAMPTZ NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TrackingEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "DangerousGoods_contentId_key" ON "DangerousGoods"("contentId");

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentInternational_shipmentId_key" ON "ShipmentInternational"("shipmentId");

-- CreateIndex
CREATE UNIQUE INDEX "PackageInternational_packageId_key" ON "PackageInternational"("packageId");

-- CreateIndex
CREATE UNIQUE INDEX "ContentInternational_contentId_key" ON "ContentInternational"("contentId");

-- CreateIndex
CREATE INDEX "ShipmentLeg_shipmentId_sequenceNumber_idx" ON "ShipmentLeg"("shipmentId", "sequenceNumber");

-- CreateIndex
CREATE INDEX "LegEvent_legId_eventTime_idx" ON "LegEvent"("legId", "eventTime");

-- CreateIndex
CREATE INDEX "ShipmentAttachment_type_idx" ON "ShipmentAttachment"("type");

-- CreateIndex
CREATE UNIQUE INDEX "AddressValidation_addressId_key" ON "AddressValidation"("addressId");

-- CreateIndex
CREATE INDEX "ShipmentAttribute_key_value_idx" ON "ShipmentAttribute"("key", "value");

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentAttribute_shipmentId_key_key" ON "ShipmentAttribute"("shipmentId", "key");

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentIntegration_shipmentId_key" ON "ShipmentIntegration"("shipmentId");

-- CreateIndex
CREATE INDEX "ShipmentNotification_shipmentId_status_idx" ON "ShipmentNotification"("shipmentId", "status");

-- CreateIndex
CREATE INDEX "ShipmentNotification_recipient_idx" ON "ShipmentNotification"("recipient");

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentMeta_shipmentId_key" ON "ShipmentMeta"("shipmentId");

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentMeta_idempotencyKey_key" ON "ShipmentMeta"("idempotencyKey");

-- CreateIndex
CREATE INDEX "ShipmentStatusHistory_shipmentId_changedAt_idx" ON "ShipmentStatusHistory"("shipmentId", "changedAt");

-- CreateIndex
CREATE INDEX "ShipmentPricing_shipmentId_type_idx" ON "ShipmentPricing"("shipmentId", "type");

-- CreateIndex
CREATE INDEX "NewShipment_trackingNumber_idx" ON "NewShipment"("trackingNumber");

-- CreateIndex
CREATE INDEX "NewShipment_customerReference_idx" ON "NewShipment"("customerReference");

-- CreateIndex
CREATE INDEX "NewShipment_supplierReference_idx" ON "NewShipment"("supplierReference");

-- CreateIndex
CREATE UNIQUE INDEX "NewShipment_shipmentReferenceId_key" ON "NewShipment"("shipmentReferenceId");

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentTracking_shipmentId_key" ON "ShipmentTracking"("shipmentId");

-- CreateIndex
CREATE INDEX "TrackingEvent_trackingNumber_eventTime_idx" ON "TrackingEvent"("trackingNumber", "eventTime");

-- CreateIndex
CREATE INDEX "Address_postcode_suburb_idx" ON "Address"("postcode", "suburb");

-- CreateIndex
CREATE INDEX "Address_zoneCardZoneId_idx" ON "Address"("zoneCardZoneId");

-- CreateIndex
CREATE INDEX "Package_number_idx" ON "Package"("number");

-- CreateIndex
CREATE INDEX "Package_barcode_idx" ON "Package"("barcode");

-- CreateIndex
CREATE UNIQUE INDEX "PalletsManagement_newShipmentId_key" ON "PalletsManagement"("newShipmentId");

-- CreateIndex
CREATE INDEX "Watchlist_userId_newShipmentId_idx" ON "Watchlist"("userId", "newShipmentId");

-- AddForeignKey
ALTER TABLE "DangerousGoods" ADD CONSTRAINT "DangerousGoods_contentId_fkey" FOREIGN KEY ("contentId") REFERENCES "PackageContents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentInternational" ADD CONSTRAINT "ShipmentInternational_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "NewShipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PackageInternational" ADD CONSTRAINT "PackageInternational_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES "Package"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContentInternational" ADD CONSTRAINT "ContentInternational_contentId_fkey" FOREIGN KEY ("contentId") REFERENCES "PackageContents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentLeg" ADD CONSTRAINT "ShipmentLeg_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentLeg" ADD CONSTRAINT "ShipmentLeg_fromLocationId_fkey" FOREIGN KEY ("fromLocationId") REFERENCES "Location"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentLeg" ADD CONSTRAINT "ShipmentLeg_toLocationId_fkey" FOREIGN KEY ("toLocationId") REFERENCES "Location"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentLeg" ADD CONSTRAINT "ShipmentLeg_newShipmentId_fkey" FOREIGN KEY ("newShipmentId") REFERENCES "NewShipment"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LegEvent" ADD CONSTRAINT "LegEvent_legId_fkey" FOREIGN KEY ("legId") REFERENCES "ShipmentLeg"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentAttachment" ADD CONSTRAINT "ShipmentAttachment_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "NewShipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AddressValidation" ADD CONSTRAINT "AddressValidation_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Address"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentAttribute" ADD CONSTRAINT "ShipmentAttribute_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "NewShipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentIntegration" ADD CONSTRAINT "ShipmentIntegration_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "NewShipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentNotification" ADD CONSTRAINT "ShipmentNotification_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "NewShipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentMeta" ADD CONSTRAINT "ShipmentMeta_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "NewShipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentStatusHistory" ADD CONSTRAINT "ShipmentStatusHistory_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "NewShipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentPricing" ADD CONSTRAINT "ShipmentPricing_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentPricing" ADD CONSTRAINT "ShipmentPricing_newShipmentId_fkey" FOREIGN KEY ("newShipmentId") REFERENCES "NewShipment"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingSurcharge" ADD CONSTRAINT "PricingSurcharge_pricingId_fkey" FOREIGN KEY ("pricingId") REFERENCES "ShipmentPricing"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Package" ADD CONSTRAINT "Package_newShipmentId_fkey" FOREIGN KEY ("newShipmentId") REFERENCES "NewShipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PalletsManagement" ADD CONSTRAINT "PalletsManagement_newShipmentId_fkey" FOREIGN KEY ("newShipmentId") REFERENCES "NewShipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Paperwork" ADD CONSTRAINT "Paperwork_newShipmentId_fkey" FOREIGN KEY ("newShipmentId") REFERENCES "NewShipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentDetailSpecialService" ADD CONSTRAINT "ShipmentDetailSpecialService_shipmentDetailsId_fkey" FOREIGN KEY ("shipmentDetailsId") REFERENCES "ShipmentDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NewShipment" ADD CONSTRAINT "NewShipment_pickupId_fkey" FOREIGN KEY ("pickupId") REFERENCES "Pickup"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NewShipment" ADD CONSTRAINT "NewShipment_shipmentDetailsId_fkey" FOREIGN KEY ("shipmentDetailsId") REFERENCES "ShipmentDetails"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NewShipment" ADD CONSTRAINT "NewShipment_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "Sender"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NewShipment" ADD CONSTRAINT "NewShipment_receiverId_fkey" FOREIGN KEY ("receiverId") REFERENCES "Receiver"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NewShipment" ADD CONSTRAINT "NewShipment_manifestId_fkey" FOREIGN KEY ("manifestId") REFERENCES "ManifestShipment"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NewShipment" ADD CONSTRAINT "NewShipment_shipmentTrackingId_fkey" FOREIGN KEY ("shipmentTrackingId") REFERENCES "ShipmentTracking"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentTracking" ADD CONSTRAINT "ShipmentTracking_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrackingTimeslot" ADD CONSTRAINT "TrackingTimeslot_trackingId_fkey" FOREIGN KEY ("trackingId") REFERENCES "ShipmentTracking"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrackingEvent" ADD CONSTRAINT "TrackingEvent_trackingId_fkey" FOREIGN KEY ("trackingId") REFERENCES "ShipmentTracking"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Watchlist" ADD CONSTRAINT "Watchlist_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Watchlist" ADD CONSTRAINT "Watchlist_newShipmentId_fkey" FOREIGN KEY ("newShipmentId") REFERENCES "NewShipment"("id") ON DELETE SET NULL ON UPDATE CASCADE;
