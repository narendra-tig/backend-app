-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "SessionModule" ADD VALUE 'AUTHENTICATED';
ALTER TYPE "SessionModule" ADD VALUE 'ACCESSING_CUSTOMER_ACCOUNT';

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "isAccessingCustomerAccountEnabled" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "UserSession" ADD COLUMN     "accessingAccountId" UUID,
ADD COLUMN     "accessingBy" UUID,
ADD COLUMN     "accessingConnectionModuleType" TEXT,
ADD COLUMN     "isAccessingCustomerAccount" BOOLEAN NOT NULL DEFAULT false;
