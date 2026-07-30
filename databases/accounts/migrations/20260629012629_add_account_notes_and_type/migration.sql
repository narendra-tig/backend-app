-- CreateEnum
CREATE TYPE "AccountType" AS ENUM ('MANAGED', 'SAAS', 'B2B', 'B2C');

-- CreateEnum
CREATE TYPE "RoleAssignmentType" AS ENUM ('SALES_REP', 'FREIGHT_INVESTIGATOR', 'FREIGHT_ADVISOR', 'PORTFOLIO_OWNER');

-- AlterTable
ALTER TABLE "Account" ADD COLUMN     "type" "AccountType" NOT NULL DEFAULT 'MANAGED';

-- CreateTable
CREATE TABLE "AccountRoleAssignment" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "accountId" UUID NOT NULL,
    "userId" UUID NOT NULL,
    "roleId" UUID NOT NULL,
    "type" "RoleAssignmentType" NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AccountRoleAssignment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AccountRoleMapping" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "roleId" UUID NOT NULL,
    "accountId" UUID NOT NULL,
    "type" "RoleAssignmentType" NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AccountRoleMapping_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Note" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "accountId" UUID NOT NULL,
    "createdBy" UUID NOT NULL,
    "content" TEXT NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "isPinned" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Note_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "AccountRoleAssignment_accountId_roleId_key" ON "AccountRoleAssignment"("accountId", "roleId");

-- CreateIndex
CREATE UNIQUE INDEX "AccountRoleMapping_accountId_roleId_type_key" ON "AccountRoleMapping"("accountId", "roleId", "type");

-- AddForeignKey
ALTER TABLE "AccountRoleAssignment" ADD CONSTRAINT "AccountRoleAssignment_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Note" ADD CONSTRAINT "Note_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE CASCADE ON UPDATE CASCADE;
