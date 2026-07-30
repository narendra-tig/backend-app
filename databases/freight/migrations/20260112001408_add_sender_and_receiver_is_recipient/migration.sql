-- AlterTable
ALTER TABLE "Receiver" ADD COLUMN     "isRecipient" BOOLEAN DEFAULT false;

-- AlterTable
ALTER TABLE "Sender" ADD COLUMN     "isRecipient" BOOLEAN DEFAULT false;