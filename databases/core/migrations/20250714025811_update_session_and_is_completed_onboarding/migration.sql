-- AlterEnum
ALTER TYPE "SessionModule" ADD VALUE 'UPDATE_SESSION';

-- AlterTable
ALTER TABLE "AccountUser" ALTER COLUMN "isCompletedOnboarding" SET DEFAULT false;

-- AlterTable
ALTER TABLE "HubUser" ALTER COLUMN "isCompletedOnboarding" SET DEFAULT false;

-- AlterTable
ALTER TABLE "TenancyUser" ALTER COLUMN "isCompletedOnboarding" SET DEFAULT false;

-- AlterTable
ALTER TABLE "UserSession" ALTER COLUMN "isVerified" SET DEFAULT false;
