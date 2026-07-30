-- AlterTable
ALTER TABLE "CustomerGroup" ADD COLUMN     "billingCode" SERIAL NOT NULL;
ALTER SEQUENCE "CustomerGroup_billingCode_seq" RESTART WITH 100000;
ALTER TABLE "Account" ADD COLUMN     "billingCode" INTEGER;