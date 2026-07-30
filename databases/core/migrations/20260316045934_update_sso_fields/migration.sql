-- CreateEnum
CREATE TYPE "SsoConfigurationStatus" AS ENUM ('ACTIVE', 'PENDING', 'INACTIVE');

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "ssoAccountCode" TEXT DEFAULT '';

-- CreateTable
CREATE TABLE "SsoConfiguration" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenantId" UUID NOT NULL,
    "accountCode" TEXT NOT NULL,
    "entryPoint" TEXT,
    "callbackUrl" TEXT,
    "cert" TEXT,
    "issuer" TEXT,
    "status" "SsoConfigurationStatus" NOT NULL DEFAULT 'PENDING',
    "hierarchyLevel" TEXT NOT NULL,
    "accountId" UUID,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SsoConfiguration_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_sso_configuration_account_code" ON "SsoConfiguration"("accountCode");

-- CreateIndex
CREATE UNIQUE INDEX "SsoConfiguration_tenantId_accountCode_key" ON "SsoConfiguration"("tenantId", "accountCode");
