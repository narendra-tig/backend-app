-- CreateTable
CREATE TABLE "SurchargeCategory" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SurchargeCategory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SurchargeSubCategory" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "surchargeCategoryId" UUID NOT NULL,

    CONSTRAINT "SurchargeSubCategory_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "SurchargeSubCategory" ADD CONSTRAINT "SurchargeSubCategory_surchargeCategoryId_fkey" FOREIGN KEY ("surchargeCategoryId") REFERENCES "SurchargeCategory"("id") ON DELETE CASCADE ON UPDATE CASCADE;
