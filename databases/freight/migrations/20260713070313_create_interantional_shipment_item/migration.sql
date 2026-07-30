-- CreateTable
CREATE TABLE "InternationalShipmentItem" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "description" TEXT NOT NULL,
    "tariffCode" TEXT NOT NULL,
    "origin" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "accountId" UUID NOT NULL,
    "contentId" UUID,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InternationalShipmentItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TariffCode" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "code" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TariffCode_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OriginCountry" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "country" TEXT NOT NULL,
    "countryCode" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "OriginCountry_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "InternationalShipmentItem_tenantId_accountId_idx" ON "InternationalShipmentItem"("tenantId", "accountId");

-- CreateIndex
CREATE UNIQUE INDEX "TariffCode_code_key" ON "TariffCode"("code");

-- CreateIndex
CREATE UNIQUE INDEX "OriginCountry_countryCode_key" ON "OriginCountry"("countryCode");

-- Enable RLS on InternationalShipmentItem
ALTER TABLE "InternationalShipmentItem" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "InternationalShipmentItem" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "InternationalShipmentItem" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "InternationalShipmentItem" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');