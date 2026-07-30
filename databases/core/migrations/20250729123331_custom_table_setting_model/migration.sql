-- CreateEnum
CREATE TYPE "TableType" AS ENUM ('READY_TO_SHIP', 'MANIFESTS', 'MANIFESTED', 'QUOTE', 'DRAFT', 'PICKUP');

-- CreateTable
CREATE TABLE "CustomTableSetting" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "type" "TableType" NOT NULL DEFAULT 'READY_TO_SHIP',
    "data" JSONB,
    "userId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMPTZ(6),
    "tenantId" UUID NOT NULL,

    CONSTRAINT "CustomTableSetting_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CustomTableSetting_userId_type_key" ON "CustomTableSetting"("userId", "type");

-- AddForeignKey
ALTER TABLE "CustomTableSetting" ADD CONSTRAINT "CustomTableSetting_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
