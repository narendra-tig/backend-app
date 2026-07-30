/*
  Warnings:

  - You are about to drop the column `ofId` on the `OrganisationalUnit` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "OrganisationalUnit" DROP COLUMN "ofId",
ADD COLUMN     "ofAccountId" UUID,
ADD COLUMN     "ofCustomerGroupId" UUID;
