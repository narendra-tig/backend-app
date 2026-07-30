-- CreateEnum
CREATE TYPE "CustomerGroupBillingStatus" AS ENUM ('ACTIVE', 'INACTIVE');

-- CreateEnum
CREATE TYPE "BillingGroupType" AS ENUM ('ACCOUNT', 'SELF', 'GROUP');

-- CreateEnum
CREATE TYPE "TradingTermsType" AS ENUM ('END_OF_MONTH', 'INVOICE_DATE', 'PREPAID');

-- CreateEnum
CREATE TYPE "InvoiceCycle" AS ENUM ('WEEKLY', 'FORTNIGHTLY', 'MONTHLY');

-- CreateTable
CREATE TABLE "CustomerGroupBilling" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "customerGroupId" UUID NOT NULL,
    "accountId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "billingCode" INTEGER NOT NULL,
    "status" "CustomerGroupBillingStatus" NOT NULL,
    "billingGroupType" "BillingGroupType" NOT NULL,
    "billingCustomerGroupId" UUID,
    "tradingTermsDays" INTEGER,
    "tradingTermsType" "TradingTermsType",
    "invoiceCycle" "InvoiceCycle",
    "businessName" TEXT,
    "abn" TEXT,
    "acn" TEXT,
    "myobName" TEXT,
    "invoiceEmails" TEXT[],
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CustomerGroupBilling_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CustomerGroupBilling_customerGroupId_key" ON "CustomerGroupBilling"("customerGroupId");

-- AddForeignKey
ALTER TABLE "CustomerGroupBilling" ADD CONSTRAINT "CustomerGroupBilling_customerGroupId_fkey" FOREIGN KEY ("customerGroupId") REFERENCES "CustomerGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;
