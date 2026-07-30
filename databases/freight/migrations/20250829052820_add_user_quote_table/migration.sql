-- CreateEnum
CREATE TYPE "public"."UserQuoteStatus" AS ENUM ('Q_QUOTE', 'Q_DRAFT');

-- CreateTable
CREATE TABLE "public"."UserQuote" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "quoteNumber" TEXT NOT NULL,
    "data" JSONB NOT NULL,
    "accountId" UUID NOT NULL,
    "customerGroupId" UUID NOT NULL,
    "dispatchDate" TIMESTAMPTZ,
    "senderName" TEXT,
    "senderAddress" TEXT,
    "senderCountry" TEXT DEFAULT '',
    "senderState" TEXT DEFAULT '',
    "senderSuburb" TEXT DEFAULT '',
    "senderPostcode" TEXT DEFAULT '',
    "receiverName" TEXT,
    "receiverAddress" TEXT,
    "receiverState" TEXT DEFAULT '',
    "receiverPostcode" TEXT DEFAULT '',
    "receiverCountry" TEXT DEFAULT '',
    "receiverSuburb" TEXT DEFAULT '',
    "carrier" TEXT,
    "serviceName" TEXT,
    "estimatedPrice" MONEY,
    "status" "public"."UserQuoteStatus" DEFAULT 'Q_QUOTE',
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "eta" TEXT DEFAULT '',
    "internalReference" TEXT DEFAULT '',
    "quoteReference" TEXT DEFAULT '',
    "totalQuantity" INTEGER,
    "totalWeight" DECIMAL(65,30),
    "totalVolume" DECIMAL(65,30),

    CONSTRAINT "UserQuote_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "UserQuote_quoteNumber_key" ON "public"."UserQuote"("quoteNumber");
