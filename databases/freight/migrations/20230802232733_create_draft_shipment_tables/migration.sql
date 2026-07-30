-- CreateTable
CREATE TABLE "DraftShipment" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "data" JSONB NOT NULL,
    "accountId" UUID NOT NULL,
    "customerGroupId" UUID NOT NULL,
    "dispatchDate" TIMESTAMPTZ,
    "senderName" TEXT,
    "senderAddress" TEXT,
    "receiverName" TEXT,
    "receiverAddress" TEXT,
    "supplier" TEXT,
    "supplierService" TEXT,
    "estimatedPrice" TEXT,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,

    CONSTRAINT "DraftShipment_pkey" PRIMARY KEY ("id")
);
