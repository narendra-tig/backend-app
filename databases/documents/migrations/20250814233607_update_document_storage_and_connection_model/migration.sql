-- CreateEnum
CREATE TYPE "public"."ResourceType" AS ENUM ('SHIPMENT', 'MANIFEST', 'POD', 'LABEL', 'RATE_CARD_SELL', 'RATE_CARD_BUY', 'TERMS_AND_CONDITIONS_ACCOUNT', 'TERMS_AND_CONDITIONS_TENANCY', 'TERMS_AND_CONDITIONS_GLOBAL', 'TERMS_AND_CONDITIONS_CUSTOMER_GROUP', 'ZONES', 'REPORT', 'ZONE_CARD', 'SURCHARGE_SELL', 'SURCHARGE_BUY', 'FUEL_LEVY_SELL', 'FUEL_LEVY_BUY', 'ZONE_ETA', 'INVOICE', 'CUSTOM', 'OTHER', 'ACCOUNT_LOGO', 'ACCOUNT_ICON', 'ACCOUNTS', 'DANGEROUS_GOODS', 'TENANCY', 'TENANCY_LOGO', 'TENANCY_ICON', 'USER_PROFILE_PICTURE');

-- CreateTable
CREATE TABLE "public"."DocumentConnection" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "accountId" TEXT,
    "shipmentId" TEXT,
    "manifestId" TEXT,
    "mimeType" TEXT,
    "fileName" TEXT NOT NULL,
    "customerGroupId" TEXT,
    "resourceType" "public"."ResourceType",
    "storageUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DocumentConnection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."DocumentStorage" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "path" TEXT NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "mimeType" TEXT,
    "fileName" TEXT NOT NULL,
    "resourceType" "public"."ResourceType",
    "storageUrl" TEXT,
    "repository" TEXT,
    "isPublic" BOOLEAN NOT NULL DEFAULT false,
    "isShared" BOOLEAN NOT NULL DEFAULT false,
    "downloadCount" INTEGER NOT NULL DEFAULT 0,
    "userId" TEXT,
    "accountId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DocumentStorage_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."DocumentStorage" ADD CONSTRAINT "DocumentStorage_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."DocumentConnection"("id") ON DELETE CASCADE ON UPDATE CASCADE;
