-- AlterTable
ALTER TABLE "Account" ADD COLUMN     "ofAccountId" UUID,
ADD COLUMN     "ofBillingCode" INTEGER;

-- AlterTable
ALTER TABLE "CustomerGroup" ADD COLUMN     "ofCustomerGroupBillingCode" UUID,
ADD COLUMN     "ofCustomerGroupId" UUID;
