-- CreateEnum
CREATE TYPE "PrinterType" AS ENUM ('THERMAL', 'CLOUD', 'PDF');

-- CreateTable
CREATE TABLE "PrinterSetting" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "type" "PrinterType" NOT NULL,
    "printerId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "margin" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "PrinterSetting_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PrinterSetting_userId_key" ON "PrinterSetting"("userId");

-- AddForeignKey
ALTER TABLE "PrinterSetting" ADD CONSTRAINT "PrinterSetting_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
