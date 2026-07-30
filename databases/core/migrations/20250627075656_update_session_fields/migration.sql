-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "SessionModule" ADD VALUE 'PASSWORD_RESET_INVITATION';
ALTER TYPE "SessionModule" ADD VALUE 'ACCEPTED_INVITATION';
ALTER TYPE "SessionModule" ADD VALUE 'ACCEPTED_ONBOARDING';
ALTER TYPE "SessionModule" ADD VALUE 'PASSWORD_CREATED';
ALTER TYPE "SessionModule" ADD VALUE 'PASSWORD_UPDATED';

-- AlterTable
ALTER TABLE "UserSession" ADD COLUMN     "isOnboarded" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "isVerified" BOOLEAN NOT NULL DEFAULT true;
