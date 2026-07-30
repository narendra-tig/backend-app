/*
  Warnings:

  - A unique constraint covering the columns `[pickupReference]` on the table `Pickup` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `pickupReference` to the `Pickup` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
ALTER TYPE "Command" ADD VALUE 'BOOK_PICKUP';

-- AlterTable
ALTER TABLE "Pickup" ADD COLUMN     "pickupReference" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "PickupTask" (
    "pickupId" UUID NOT NULL,
    "taskId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "Identifier" (
    "id" TEXT NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,

    CONSTRAINT "Identifier_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PickupTask_pickupId_taskId_key" ON "PickupTask"("pickupId", "taskId");

-- CreateIndex
CREATE UNIQUE INDEX "Identifier_tenantId_id_key" ON "Identifier"("tenantId", "id");

-- CreateIndex
CREATE UNIQUE INDEX "Pickup_pickupReference_key" ON "Pickup"("pickupReference");

-- AddForeignKey
ALTER TABLE "PickupTask" ADD CONSTRAINT "PickupTask_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PickupTask" ADD CONSTRAINT "PickupTask_pickupId_fkey" FOREIGN KEY ("pickupId") REFERENCES "Pickup"("id") ON DELETE CASCADE ON UPDATE CASCADE;


-- Enable RLS

-- PickupTask
ALTER TABLE "PickupTask" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "PickupTask" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "PickupTask" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "PickupTask" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

-- Identifier
ALTER TABLE "Identifier" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Identifier" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Identifier" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Identifier" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');
