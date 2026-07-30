/*
  Warnings:

  - A unique constraint covering the columns `[fileName]` on the table `DocumentStorage` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "public"."DocumentStorage" DROP CONSTRAINT "DocumentStorage_id_fkey";

-- CreateIndex
CREATE UNIQUE INDEX "DocumentStorage_fileName_key" ON "public"."DocumentStorage"("fileName");

-- AddForeignKey
ALTER TABLE "public"."DocumentConnection" ADD CONSTRAINT "DocumentConnection_id_fkey" FOREIGN KEY ("id") REFERENCES "public"."DocumentStorage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
