-- CreateTable
CREATE TABLE "CustomPackage" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "code" TEXT,
    "type" TEXT,
    "quantity" INTEGER,
    "length" INTEGER,
    "width" INTEGER,
    "height" INTEGER,
    "weight" INTEGER,
    "isDangerousGoods" BOOLEAN,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "accountId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CustomPackage_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CustomPackage" ADD CONSTRAINT "CustomPackage_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;
