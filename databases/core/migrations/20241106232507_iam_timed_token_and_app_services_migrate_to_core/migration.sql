-- CreateEnum
CREATE TYPE "RoleType" AS ENUM ('TENANCY', 'ACCOUNT');

-- CreateEnum
CREATE TYPE "PermissionType" AS ENUM ('TENANCY', 'ACCOUNT', 'HUB');

-- CreateEnum
CREATE TYPE "TimedTokenType" AS ENUM ('ROOT_USER_INVITATION', 'TENANCY_USER_INVITATION', 'ACCOUNT_USER_INVITATION', 'HUB_USER_INVITATION', 'RESET_PASSWORD');

-- CreateTable
CREATE TABLE "Connection" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "organisationalUnitId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Connection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Role" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "description" TEXT,
    "type" "RoleType" NOT NULL,
    "accountId" UUID,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Permission" (
    "name" TEXT NOT NULL,
    "type" "PermissionType"[],

    CONSTRAINT "Permission_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "Namespace" (
    "name" TEXT NOT NULL,

    CONSTRAINT "Namespace_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "NamespacesData" (
    "data" JSONB NOT NULL
);

-- CreateTable
CREATE TABLE "TimedToken" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "token" TEXT NOT NULL,
    "type" "TimedTokenType" NOT NULL,
    "userId" UUID NOT NULL,
    "expiryTime" TIMESTAMP(3) NOT NULL,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "TimedToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TenancyUser" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "isCompletedOnboarding" BOOLEAN NOT NULL DEFAULT true,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "TenancyUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AccountUser" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "isCompletedOnboarding" BOOLEAN NOT NULL DEFAULT true,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "AccountUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HubUser" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "isCompletedOnboarding" BOOLEAN NOT NULL DEFAULT true,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "HubUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ConnectionToRole" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_ConnectionToPermission" (
    "A" UUID NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_PermissionToRole" (
    "A" TEXT NOT NULL,
    "B" UUID NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Connection_userId_organisationalUnitId_key" ON "Connection"("userId", "organisationalUnitId");

-- CreateIndex
CREATE UNIQUE INDEX "NamespacesData_data_key" ON "NamespacesData"("data");

-- CreateIndex
CREATE UNIQUE INDEX "TimedToken_userId_key" ON "TimedToken"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "TenancyUser_userId_key" ON "TenancyUser"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "AccountUser_userId_key" ON "AccountUser"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "HubUser_userId_key" ON "HubUser"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "_ConnectionToRole_AB_unique" ON "_ConnectionToRole"("A", "B");

-- CreateIndex
CREATE INDEX "_ConnectionToRole_B_index" ON "_ConnectionToRole"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ConnectionToPermission_AB_unique" ON "_ConnectionToPermission"("A", "B");

-- CreateIndex
CREATE INDEX "_ConnectionToPermission_B_index" ON "_ConnectionToPermission"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_PermissionToRole_AB_unique" ON "_PermissionToRole"("A", "B");

-- CreateIndex
CREATE INDEX "_PermissionToRole_B_index" ON "_PermissionToRole"("B");

-- AddForeignKey
ALTER TABLE "TimedToken" ADD CONSTRAINT "TimedToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TenancyUser" ADD CONSTRAINT "TenancyUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AccountUser" ADD CONSTRAINT "AccountUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HubUser" ADD CONSTRAINT "HubUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ConnectionToRole" ADD CONSTRAINT "_ConnectionToRole_A_fkey" FOREIGN KEY ("A") REFERENCES "Connection"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ConnectionToRole" ADD CONSTRAINT "_ConnectionToRole_B_fkey" FOREIGN KEY ("B") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ConnectionToPermission" ADD CONSTRAINT "_ConnectionToPermission_A_fkey" FOREIGN KEY ("A") REFERENCES "Connection"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ConnectionToPermission" ADD CONSTRAINT "_ConnectionToPermission_B_fkey" FOREIGN KEY ("B") REFERENCES "Permission"("name") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionToRole" ADD CONSTRAINT "_PermissionToRole_A_fkey" FOREIGN KEY ("A") REFERENCES "Permission"("name") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionToRole" ADD CONSTRAINT "_PermissionToRole_B_fkey" FOREIGN KEY ("B") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;
