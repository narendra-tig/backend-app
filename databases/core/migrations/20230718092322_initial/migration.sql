-- CreateEnum
CREATE TYPE "OrganisationalUnitType" AS ENUM ('tenancy', 'account');

-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('pending', 'invited', 'active', 'inactive');

-- CreateEnum
CREATE TYPE "UserType" AS ENUM ('root', 'tenancy', 'account', 'hub');

-- CreateEnum
CREATE TYPE "TextSize" AS ENUM ('small', 'medium', 'large');

-- CreateEnum
CREATE TYPE "ColourMode" AS ENUM ('light', 'dark');

-- CreateEnum
CREATE TYPE "Spacing" AS ENUM ('regular', 'compact');

-- CreateTable
CREATE TABLE "Tenant" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "firebaseId" TEXT NOT NULL,
    "ownerId" UUID,
    "displayName" TEXT NOT NULL,
    "organisationalUnitId" UUID,

    CONSTRAINT "Tenant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TenantDetails" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "bucketName" TEXT NOT NULL,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "TenantDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrganisationalUnit" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "namespace" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "displayName" TEXT NOT NULL,
    "type" "OrganisationalUnitType" NOT NULL,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "OrganisationalUnit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrganisationalUnitEdge" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "fromId" UUID NOT NULL,
    "toId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "OrganisationalUnitEdge_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "email" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "isVerified" BOOLEAN NOT NULL DEFAULT false,
    "status" "UserStatus" NOT NULL,
    "type" "UserType" NOT NULL,
    "firebaseId" TEXT NOT NULL,
    "jobTitle" TEXT,
    "phoneNumber" TEXT,
    "avatar" TEXT,
    "organisationalUnitId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AccessibilitySettings" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "textSize" "TextSize" NOT NULL DEFAULT 'medium',
    "colourMode" "ColourMode" NOT NULL DEFAULT 'light',
    "spacing" "Spacing" NOT NULL DEFAULT 'regular',
    "userId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "AccessibilitySettings_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Tenant_name_key" ON "Tenant"("name");

-- CreateIndex
CREATE UNIQUE INDEX "TenantDetails_tenantId_key" ON "TenantDetails"("tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "OrganisationalUnit_name_namespace_tenantId_key" ON "OrganisationalUnit"("name", "namespace", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "OrganisationalUnitEdge_fromId_toId_key" ON "OrganisationalUnitEdge"("fromId", "toId");

-- CreateIndex
CREATE UNIQUE INDEX "User_firebaseId_key" ON "User"("firebaseId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_tenantId_key" ON "User"("email", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "AccessibilitySettings_userId_key" ON "AccessibilitySettings"("userId");

-- AddForeignKey
ALTER TABLE "TenantDetails" ADD CONSTRAINT "TenantDetails_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrganisationalUnit" ADD CONSTRAINT "OrganisationalUnit_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrganisationalUnitEdge" ADD CONSTRAINT "OrganisationalUnitEdge_fromId_fkey" FOREIGN KEY ("fromId") REFERENCES "OrganisationalUnit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrganisationalUnitEdge" ADD CONSTRAINT "OrganisationalUnitEdge_toId_fkey" FOREIGN KEY ("toId") REFERENCES "OrganisationalUnit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrganisationalUnitEdge" ADD CONSTRAINT "OrganisationalUnitEdge_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_organisationalUnitId_fkey" FOREIGN KEY ("organisationalUnitId") REFERENCES "OrganisationalUnit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AccessibilitySettings" ADD CONSTRAINT "AccessibilitySettings_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AccessibilitySettings" ADD CONSTRAINT "AccessibilitySettings_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
