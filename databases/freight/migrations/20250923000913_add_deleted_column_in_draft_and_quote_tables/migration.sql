-- AlterTable
ALTER TABLE "public"."DraftShipment" ADD COLUMN     "deleted" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "public"."UserQuote" ADD COLUMN     "deleted" BOOLEAN NOT NULL DEFAULT false;
