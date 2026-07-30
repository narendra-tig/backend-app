-- AlterTable
ALTER TABLE "Connection" ADD COLUMN     "accountId" UUID,
ADD COLUMN     "isDefault" BOOLEAN NOT NULL DEFAULT false;
