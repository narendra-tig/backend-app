-- CreateTable
CREATE TABLE "public"."TenancyPreference" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "uniqueReference" BOOLEAN DEFAULT false,
    "allowVolume" BOOLEAN DEFAULT false,
    "allowThirdParty" BOOLEAN DEFAULT false,
    "dimensionsRequired" BOOLEAN DEFAULT false,
    "quoteInclusiveTax" BOOLEAN DEFAULT false,
    "lowestShippingCostOnly" BOOLEAN DEFAULT false,
    "calculateItemTotal" BOOLEAN DEFAULT false,
    "receiverDefaultResidential" BOOLEAN DEFAULT false,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMPTZ,

    CONSTRAINT "TenancyPreference_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "TenancyPreference_tenantId_key" ON "public"."TenancyPreference"("tenantId");
