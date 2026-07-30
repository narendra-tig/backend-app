CREATE TABLE "CalculatedQuote" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "data" JSONB NOT NULL,
    "accountId" UUID NOT NULL,
    "customerGroupId" UUID NOT NULL,
    "dispatchDate" TIMESTAMPTZ,
    "senderName" TEXT,
    "senderAddress" TEXT,
    "receiverName" TEXT,
    "receiverAddress" TEXT,
    "carrier" TEXT,
    "serviceName" TEXT,
    "estimatedPrice" MONEY,
    "eta" TEXT DEFAULT '',
    "quoteReference" TEXT DEFAULT '',
    "internalReference" TEXT DEFAULT '',
    "totalQuantity" INTEGER,
    "totalWeight" DECIMAL(65,30),
    "totalVolume" DECIMAL(65,30),
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "deleted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "CalculatedQuote_pkey" PRIMARY KEY ("id")
);

CREATE INDEX "CalculatedQuote_accountId_customerGroupId_createdAt_idx"
ON "CalculatedQuote"("accountId", "customerGroupId", "createdAt");

ALTER TABLE "CalculatedQuote" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CalculatedQuote" FORCE ROW LEVEL SECURITY;

CREATE POLICY tenant_isolation_policy ON "CalculatedQuote"
USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);

CREATE POLICY bypass_rls_policy ON "CalculatedQuote"
USING (current_setting('app.bypass_rls', true)::text = 'on');
