-- CreateTable
CREATE TABLE "DocumentSetting" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "customerGroupId" UUID NOT NULL,
    "printerId" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "DocumentSetting_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "DocumentSetting_customerGroupId_key" ON "DocumentSetting"("customerGroupId");

-- AddForeignKey
ALTER TABLE "DocumentSetting" ADD CONSTRAINT "DocumentSetting_customerGroupId_fkey" FOREIGN KEY ("customerGroupId") REFERENCES "CustomerGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;
