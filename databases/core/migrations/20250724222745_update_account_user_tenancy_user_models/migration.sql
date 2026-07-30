/*
  Warnings:

  - A unique constraint covering the columns `[userId,accountId]` on the table `AccountUser` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userId,tenantId]` on the table `TenancyUser` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "AccountUser" ADD COLUMN     "accountId" UUID,
ADD COLUMN     "accountOrganisationUnitId" UUID;

-- AlterTable
ALTER TABLE "TenancyUser" ADD COLUMN     "tenantOrganisationUnitId" UUID;

-- CreateIndex
CREATE UNIQUE INDEX "AccountUser_userId_accountId_key" ON "AccountUser"("userId", "accountId");

-- CreateIndex
CREATE UNIQUE INDEX "TenancyUser_userId_tenantId_key" ON "TenancyUser"("userId", "tenantId");
