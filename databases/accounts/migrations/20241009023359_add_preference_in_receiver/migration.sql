-- AlterTable
ALTER TABLE "Address" ADD COLUMN     "addressLine3" TEXT;

-- AlterTable
ALTER TABLE "Receiver" ADD COLUMN     "authorityToLeave" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "specialInstructions" TEXT;
