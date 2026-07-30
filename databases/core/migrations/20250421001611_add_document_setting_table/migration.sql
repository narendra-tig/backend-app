-- AlterTable
ALTER TABLE "PrinterSetting" ADD COLUMN     "darkness" INTEGER DEFAULT 0;

-- CreateTable
CREATE TABLE "DocumentSetting" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "printerId" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "DocumentSetting_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "DocumentSetting_userId_key" ON "DocumentSetting"("userId");

-- AddForeignKey
ALTER TABLE "DocumentSetting" ADD CONSTRAINT "DocumentSetting_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
