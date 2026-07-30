-- AlterTable
ALTER TABLE "Pickup" ALTER COLUMN "internalReference" DROP NOT NULL,
ALTER COLUMN "pickupArea" DROP NOT NULL,
ALTER COLUMN "specialInstructions" DROP NOT NULL;
