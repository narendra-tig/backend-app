-- CreateTable
CREATE TABLE "PlatformTokenManagement" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "token" TEXT NOT NULL,
    "tokenName" TEXT NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "accountId" UUID NOT NULL,
    "carrierConnectionId" TEXT[],

    CONSTRAINT "PlatformTokenManagement_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PlatformTokenManagement_token_key" ON "PlatformTokenManagement"("token");

ALTER TABLE "PlatformTokenManagement" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "PlatformTokenManagement" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "PlatformTokenManagement" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "PlatformTokenManagement" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');