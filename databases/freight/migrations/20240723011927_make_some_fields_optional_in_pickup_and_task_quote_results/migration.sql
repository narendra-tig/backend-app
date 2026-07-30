-- AlterTable
ALTER TABLE "Pickup" ALTER COLUMN "closingTime" DROP NOT NULL;

-- AlterTable
ALTER TABLE "TaskQuoteResult" ALTER COLUMN "maxBusinessDays" DROP NOT NULL,
ALTER COLUMN "minBusinessDays" DROP NOT NULL;
