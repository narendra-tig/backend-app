-- CreateTable
CREATE TABLE "public"."CustomViews" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "tableName" TEXT NOT NULL,
    "data" JSONB,
    "userId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMPTZ(6),
    "tenantId" UUID NOT NULL,

    CONSTRAINT "CustomViews_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."CustomViews" ADD CONSTRAINT "CustomViews_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AlterTable
ALTER TABLE "CustomViews" ADD COLUMN     "filtersData" JSONB;
