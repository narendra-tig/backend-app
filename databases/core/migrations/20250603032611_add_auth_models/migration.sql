-- CreateEnum
CREATE TYPE "AuthenticationType" AS ENUM ('INTERNAL', 'MICROSOFT', 'GOOGLE');

-- CreateEnum
CREATE TYPE "ConnectionModuleType" AS ENUM ('HUB', 'TENANT', 'ACCOUNT', 'CUSTOMER_GROUP', 'PUBLIC_API', 'WAREHOUSE');

-- CreateEnum
CREATE TYPE "SessionModule" AS ENUM ('AUTH_LOGIN', 'TWO_FA_CHALLENGE', 'SSO_INBOUND', 'IMPERSONATION', 'RESET_PASSWORD', 'ACCOUNT_INVITATION');

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "OrganisationalUnitType" ADD VALUE 'hub';
ALTER TYPE "OrganisationalUnitType" ADD VALUE 'customer_group';

-- DropIndex
DROP INDEX "User_firebaseId_key";

-- AlterTable
ALTER TABLE "Connection" ADD COLUMN     "appModuleId" TEXT,
ADD COLUMN     "appModuleType" "ConnectionModuleType",
ADD COLUMN     "appName" TEXT;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "applicationAccess" TEXT[],
ADD COLUMN     "isAcceptedPolicies" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "isImpersonationEnabled" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "isSSOEnabled" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "ofId" UUID,
ADD COLUMN     "ofUuid" UUID,
ADD COLUMN     "primaryApp" TEXT,
ADD COLUMN     "primaryCustomerGroupId" UUID,
ADD COLUMN     "userAttributes" JSONB,
ALTER COLUMN "firebaseId" DROP NOT NULL;

-- CreateTable
CREATE TABLE "UserCredentials" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT,
    "isVerified" BOOLEAN NOT NULL DEFAULT false,
    "isMfaEnabled" BOOLEAN NOT NULL DEFAULT false,
    "isSSOEnabled" BOOLEAN NOT NULL DEFAULT false,
    "totpSecret" TEXT,
    "lasttotpVerifiedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserCredentials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationConfiguration" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "applicationName" TEXT NOT NULL,
    "applicationConfig" JSONB NOT NULL,
    "applicationKey" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ApplicationConfiguration_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserAuthenticationProvider" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "userCredentialId" UUID,
    "authenticationType" "AuthenticationType" NOT NULL,
    "authenticationReference" JSONB NOT NULL,
    "authenticationId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserAuthenticationProvider_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuthenticationProviderCredentials" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "authenticationName" TEXT NOT NULL,
    "authenticationKey" TEXT NOT NULL,
    "authenticationType" "AuthenticationType" NOT NULL,
    "authenticationSecret" JSONB NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AuthenticationProviderCredentials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserSession" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "applicationId" TEXT NOT NULL,
    "applicationName" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "sessionModule" "SessionModule" NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "isImpersonated" BOOLEAN NOT NULL DEFAULT false,
    "impersonatedBy" UUID,
    "impersonatedConnectionModuleID" UUID,
    "impersonatedConnectionModuleType" TEXT,
    "refreshToken" TEXT,
    "refreshTokenExpiresAt" TIMESTAMP(3),
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "geo" JSONB,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UserSession_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "UserCredentials_userId_key" ON "UserCredentials"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "UserCredentials_email_key" ON "UserCredentials"("email");

-- CreateIndex
CREATE INDEX "idx_user_credentials_tenant" ON "UserCredentials"("tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "UserCredentials_email_tenantId_userId_key" ON "UserCredentials"("email", "tenantId", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationConfiguration_applicationKey_key" ON "ApplicationConfiguration"("applicationKey");

-- CreateIndex
CREATE INDEX "idx_user_authentication_provider_credential" ON "UserAuthenticationProvider"("userCredentialId");

-- CreateIndex
CREATE UNIQUE INDEX "UserAuthenticationProvider_userId_tenantId_authenticationTy_key" ON "UserAuthenticationProvider"("userId", "tenantId", "authenticationType", "authenticationId");

-- CreateIndex
CREATE UNIQUE INDEX "UserSession_sessionToken_key" ON "UserSession"("sessionToken");

-- CreateIndex
CREATE UNIQUE INDEX "UserSession_refreshToken_key" ON "UserSession"("refreshToken");

-- CreateIndex
CREATE INDEX "UserSession_userId_idx" ON "UserSession"("userId");

-- AddForeignKey
ALTER TABLE "UserCredentials" ADD CONSTRAINT "UserCredentials_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAuthenticationProvider" ADD CONSTRAINT "UserAuthenticationProvider_userCredentialId_fkey" FOREIGN KEY ("userCredentialId") REFERENCES "UserCredentials"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAuthenticationProvider" ADD CONSTRAINT "UserAuthenticationProvider_authenticationId_fkey" FOREIGN KEY ("authenticationId") REFERENCES "AuthenticationProviderCredentials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSession" ADD CONSTRAINT "UserSession_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
