/*
  Warnings:

  - The `ofCustomerGroupBillingCode` column on the `CustomerGroup` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "CustomerGroup" DROP COLUMN "ofCustomerGroupBillingCode",
ADD COLUMN     "ofCustomerGroupBillingCode" INTEGER;
