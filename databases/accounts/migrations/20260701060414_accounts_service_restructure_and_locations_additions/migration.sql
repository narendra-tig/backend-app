-- CreateEnum
CREATE TYPE "ResourceType" AS ENUM ('account', 'customer_group', 'depot');

-- CreateEnum
CREATE TYPE "LocationType" AS ENUM ('pickup', 'delivery', 'warehouse', 'depot', 'port', 'border_crossing', 'rail_terminal', 'airport');

-- CreateEnum
CREATE TYPE "TaxIdType" AS ENUM ('ABN', 'EIN', 'VAT', 'GST', 'OTHER');

-- CreateEnum
CREATE TYPE "ContactRole" AS ENUM ('dispatch', 'receiving', 'gatehouse', 'billing', 'emergency', 'site_manager');

-- CreateEnum
CREATE TYPE "AccuracyLevel" AS ENUM ('rooftop', 'street', 'approximate');

-- CreateEnum
CREATE TYPE "GeofenceType" AS ENUM ('polygon', 'radius', 'none');

-- CreateEnum
CREATE TYPE "SurfaceType" AS ENUM ('paved', 'gravel', 'dirt');

-- CreateEnum
CREATE TYPE "VerificationSource" AS ENUM ('g_naf', 'corelogic', 'google', 'manual');

-- CreateEnum
CREATE TYPE "VerificationLevel" AS ENUM ('parcel', 'rooftop', 'street_range', 'locality');

-- AlterTable
ALTER TABLE "Location" ADD COLUMN     "accountId" UUID,
ADD COLUMN     "addressFormatted" TEXT,
ADD COLUMN     "addressLines" TEXT[],
ADD COLUMN     "administrativeArea" TEXT,
ADD COLUMN     "businessAlias" TEXT,
ADD COLUMN     "businessCustomsRegistration" TEXT,
ADD COLUMN     "businessEmail" TEXT,
ADD COLUMN     "businessName" TEXT,
ADD COLUMN     "businessPhone" TEXT,
ADD COLUMN     "businessPhoneCountryCode" TEXT NOT NULL DEFAULT '+61',
ADD COLUMN     "businessTaxId" TEXT,
ADD COLUMN     "businessTaxIdType" "TaxIdType",
ADD COLUMN     "countryCode" CHAR(2) DEFAULT 'AU',
ADD COLUMN     "extCorelogicNzId" TEXT,
ADD COLUMN     "extGnafPid" TEXT,
ADD COLUMN     "extGooglePlaceId" TEXT,
ADD COLUMN     "extHereMapId" TEXT,
ADD COLUMN     "extTomtomPlaceId" TEXT,
ADD COLUMN     "isActive" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "locality" TEXT,
ADD COLUMN     "metaInternalReference" TEXT,
ADD COLUMN     "metaLastUsedDate" TIMESTAMPTZ,
ADD COLUMN     "metaNotes" TEXT,
ADD COLUMN     "metaVerificationLevel" "VerificationLevel",
ADD COLUMN     "metaVerified" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "metaVerifiedDate" TIMESTAMPTZ,
ADD COLUMN     "postalCode" TEXT,
ADD COLUMN     "region" TEXT,
ADD COLUMN     "subAdministrativeArea" TEXT,
ADD COLUMN     "timezone" TEXT NOT NULL DEFAULT 'Australia/Sydney',
ADD COLUMN     "type" "AddressBookType",
ADD COLUMN     "version" INTEGER NOT NULL DEFAULT 1;

-- CreateTable
CREATE TABLE "LocationContact" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "locationId" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "role" "ContactRole" NOT NULL,
    "phone" TEXT,
    "phoneCountryCode" TEXT DEFAULT '+61',
    "email" TEXT,
    "preferredLanguage" TEXT DEFAULT 'en',
    "isPrimary" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LocationContact_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DispatchLocation" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "resource" TEXT NOT NULL,
    "resourceId" UUID NOT NULL,
    "locationId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,

    CONSTRAINT "DispatchLocation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReceiverLocationV2" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "resource" TEXT NOT NULL,
    "resourceId" UUID NOT NULL,
    "locationId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,

    CONSTRAINT "ReceiverLocationV2_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DepotLocation" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "resource" TEXT NOT NULL,
    "resourceId" UUID NOT NULL,
    "locationId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,

    CONSTRAINT "DepotLocation_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "LocationContact_locationId_key" ON "LocationContact"("locationId");

-- CreateIndex
CREATE INDEX "idx_dispatch_locations_resource_resource_id" ON "DispatchLocation"("resource", "resourceId");

-- CreateIndex
CREATE UNIQUE INDEX "uq_dispatch_locations_location_id" ON "DispatchLocation"("locationId");

-- CreateIndex
CREATE INDEX "idx_receiver_locations_resource_resource_id" ON "ReceiverLocationV2"("resource", "resourceId");

-- CreateIndex
CREATE UNIQUE INDEX "uq_receiver_locations_location_id" ON "ReceiverLocationV2"("locationId");

-- CreateIndex
CREATE INDEX "idx_depot_locations_resource_resource_id" ON "DepotLocation"("resource", "resourceId");

-- CreateIndex
CREATE UNIQUE INDEX "uq_depot_locations_location_id" ON "DepotLocation"("locationId");

-- AddForeignKey
ALTER TABLE "LocationContact" ADD CONSTRAINT "LocationContact_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "DispatchLocation" ADD CONSTRAINT "DispatchLocation_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ReceiverLocationV2" ADD CONSTRAINT "ReceiverLocationV2_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "DepotLocation" ADD CONSTRAINT "DepotLocation_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
