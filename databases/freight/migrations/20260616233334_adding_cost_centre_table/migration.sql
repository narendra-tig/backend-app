-- CreateTable
CREATE TABLE "CostCentre" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "code" TEXT,
    "description" TEXT,
    "accountId" UUID NOT NULL,
    "customerGroupId" UUID,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CostCentre_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "CostCentre_tenantId_accountId_idx" ON "CostCentre"("tenantId", "accountId");

-- CreateIndex
CREATE UNIQUE INDEX "CostCentre_accountId_name_key" ON "CostCentre"("accountId", "name");
