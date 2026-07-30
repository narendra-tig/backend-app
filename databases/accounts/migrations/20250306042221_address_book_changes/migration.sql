-- CreateEnum
CREATE TYPE "AddressBookType" AS ENUM ('BUSINESS', 'RESIDENTIAL');

-- AlterTable
ALTER TABLE "Address" ADD COLUMN     "type" "AddressBookType" DEFAULT 'BUSINESS';

-- AlterTable
ALTER TABLE "Receiver" ADD COLUMN     "serviceId" UUID,
ADD COLUMN     "thirdPartyAccount" TEXT;
