-- DropIndex
DROP INDEX "NamespacesData_data_key";

-- AlterTable
ALTER TABLE "NamespacesData" ADD COLUMN     "id" UUID NOT NULL DEFAULT gen_random_uuid(),
ADD CONSTRAINT "NamespacesData_pkey" PRIMARY KEY ("id");

-- CreateIndex
CREATE INDEX "NamespacesData_data_idx" ON "NamespacesData" USING HASH ("data");
