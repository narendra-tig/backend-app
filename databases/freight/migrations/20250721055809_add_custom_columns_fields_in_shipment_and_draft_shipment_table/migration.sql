-- AlterTable
ALTER TABLE "DraftShipment" ADD COLUMN     "costCentre" TEXT DEFAULT '',
ADD COLUMN     "receiverCountry" TEXT DEFAULT '',
ADD COLUMN     "receiverPostcode" TEXT DEFAULT '',
ADD COLUMN     "receiverState" TEXT DEFAULT '',
ADD COLUMN     "receiverSuburb" TEXT DEFAULT '',
ADD COLUMN     "senderCountry" TEXT DEFAULT '',
ADD COLUMN     "senderPostcode" TEXT DEFAULT '',
ADD COLUMN     "senderState" TEXT DEFAULT '',
ADD COLUMN     "senderSuburb" TEXT DEFAULT '',
ADD COLUMN     "thirdPartyAccountNumber" TEXT DEFAULT '',
ADD COLUMN     "totalQuantity" INTEGER,
ADD COLUMN     "totalVolume" DECIMAL(65,30),
ADD COLUMN     "totalWeight" DECIMAL(65,30);

-- AlterTable
ALTER TABLE "ShipmentDetails" ADD COLUMN     "totalQuantity" INTEGER,
ADD COLUMN     "totalVolume" DECIMAL(65,30),
ADD COLUMN     "totalWeight" DECIMAL(65,30);
