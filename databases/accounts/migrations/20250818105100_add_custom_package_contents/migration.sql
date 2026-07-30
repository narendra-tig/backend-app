-- CreateTable
CREATE TABLE "public"."CustomPackageContents" (
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

    CONSTRAINT "CustomPackageContents_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."CustomPackageContents" ADD CONSTRAINT "CustomPackageContents_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES "public"."CustomPackage"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CustomPackageContents" ADD CONSTRAINT "CustomPackageContents_dgId_fkey" FOREIGN KEY ("dgId") REFERENCES "public"."DangerousGoods"("id") ON DELETE SET NULL ON UPDATE CASCADE;
