-- CreateTable
CREATE TABLE "PackageContents" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "reference" TEXT,
    "packageType" TEXT,
    "quantity" INTEGER,
    "weight" DECIMAL(65,30),
    "dgType" TEXT,
    "dgId" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "packageId" UUID NOT NULL,

    CONSTRAINT "PackageContents_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "PackageContents" ADD CONSTRAINT "PackageContents_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES "Package"("id") ON DELETE CASCADE ON UPDATE CASCADE;
