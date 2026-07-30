-- CreateTable
CREATE TABLE "DangerousGoods" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "shippingName" TEXT NOT NULL,
    "unNumber" TEXT NOT NULL,
    "hazardClass" TEXT NOT NULL,
    "packagingGroup" TEXT,
    "subsidiaryRisk" TEXT,
    "hazchemCode" TEXT,
    "flashPoint" DOUBLE PRECISION,
    "shortCode" TEXT,
    "weight" DOUBLE PRECISION,
    "isMarinePollutant" BOOLEAN NOT NULL,
    "packagingInstructions" TEXT,
    "additionalInformation" TEXT,
    "tenantId" UUID NOT NULL,
    "accountId" UUID NOT NULL,
    "organisationalUnitId" UUID,
    "ofAccountId" UUID,
    "ofDangerousGoodId" UUID,
    "ofCustomerGroupId" UUID,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DangerousGoods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DangerousGoodsContact" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "contactName" TEXT NOT NULL,
    "contactNumber" TEXT NOT NULL,
    "accountId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "ofAccountId" UUID,
    "ofCustomerGroupId" UUID,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DangerousGoodsContact_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "DangerousGoods_tenantId_accountId_idx" ON "DangerousGoods"("tenantId", "accountId");

-- AddForeignKey
ALTER TABLE "DangerousGoods" ADD CONSTRAINT "DangerousGoods_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DangerousGoodsContact" ADD CONSTRAINT "DangerousGoodsContact_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "DangerousGoods" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "DangerousGoods" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "DangerousGoods" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "DangerousGoods" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "DangerousGoodsContact" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "DangerousGoodsContact" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "DangerousGoodsContact" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "DangerousGoodsContact" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');