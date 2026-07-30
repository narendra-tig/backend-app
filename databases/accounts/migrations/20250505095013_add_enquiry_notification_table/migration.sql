-- CreateTable
CREATE TABLE "EnquiryNotification" (
    "id" TEXT NOT NULL DEFAULT gen_random_uuid(),
    "enquiryId" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "accountId" TEXT NOT NULL,
    "organisationalUnitId" TEXT NOT NULL,
    "tenantId" UUID NOT NULL,

    CONSTRAINT "EnquiryNotification_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "EnquiryNotification_enquiryId_key" ON "EnquiryNotification"("enquiryId");
