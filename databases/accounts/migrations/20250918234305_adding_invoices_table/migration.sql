-- CreateTable
CREATE TABLE "public"."Invoices" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "accountId" UUID NOT NULL,
    "customerGroupId" UUID NOT NULL,
    "invoiceNumber" TEXT NOT NULL,
    "parentInvoiceNumber" TEXT,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "invoiceAmount" DECIMAL(10,2) NOT NULL,
    "gstInvoiceAmount" DECIMAL(10,2) NOT NULL,
    "invoiceDate" TIMESTAMPTZ NOT NULL,
    "fileName" TEXT,
    "fileReference" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Invoices_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Invoices_invoiceNumber_key" ON "public"."Invoices"("invoiceNumber");

-- AddForeignKey
ALTER TABLE "public"."Invoices" ADD CONSTRAINT "Invoices_customerGroupId_fkey" FOREIGN KEY ("customerGroupId") REFERENCES "public"."CustomerGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;
