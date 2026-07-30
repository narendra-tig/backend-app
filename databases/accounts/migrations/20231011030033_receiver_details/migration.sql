/*
  Warnings:

  - You are about to drop the column `customerGroupId` on the `Location` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Location" DROP CONSTRAINT "Location_customerGroupId_fkey";

-- DropIndex
DROP INDEX "Location_customerGroupId_key";

-- AlterTable
ALTER TABLE "Location" DROP COLUMN "customerGroupId";

-- CreateTable
CREATE TABLE "CustomerGroupLocation" (
    "customerGroupId" UUID NOT NULL,
    "locationId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid
);

-- CreateTable
CREATE TABLE "Receiver" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "accountId" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Receiver_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReceiverLocation" (
    "receiverId" UUID NOT NULL,
    "locationId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid
);

-- CreateIndex
CREATE UNIQUE INDEX "CustomerGroupLocation_customerGroupId_locationId_key" ON "CustomerGroupLocation"("customerGroupId", "locationId");

-- CreateIndex
CREATE UNIQUE INDEX "ReceiverLocation_receiverId_locationId_key" ON "ReceiverLocation"("receiverId", "locationId");

-- AddForeignKey
ALTER TABLE "CustomerGroupLocation" ADD CONSTRAINT "CustomerGroupLocation_customerGroupId_fkey" FOREIGN KEY ("customerGroupId") REFERENCES "CustomerGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomerGroupLocation" ADD CONSTRAINT "CustomerGroupLocation_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Receiver" ADD CONSTRAINT "Receiver_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReceiverLocation" ADD CONSTRAINT "ReceiverLocation_receiverId_fkey" FOREIGN KEY ("receiverId") REFERENCES "Receiver"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ReceiverLocation" ADD CONSTRAINT "ReceiverLocation_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE CASCADE ON UPDATE CASCADE;


-- Enable RLS
-- Receiver
ALTER TABLE "Receiver" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Receiver" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Receiver" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Receiver" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

-- ReceiverLocation
ALTER TABLE "ReceiverLocation" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "ReceiverLocation" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "ReceiverLocation" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "ReceiverLocation" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

-- CustomerGroupLocation
ALTER TABLE "CustomerGroupLocation" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "CustomerGroupLocation" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "CustomerGroupLocation" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "CustomerGroupLocation" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');
