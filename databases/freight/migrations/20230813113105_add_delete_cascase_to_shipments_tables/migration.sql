-- DropForeignKey
ALTER TABLE "Contact" DROP CONSTRAINT "Contact_locationId_fkey";

-- DropForeignKey
ALTER TABLE "Package" DROP CONSTRAINT "Package_shipmentId_fkey";

-- DropForeignKey
ALTER TABLE "PalletsManagement" DROP CONSTRAINT "PalletsManagement_shipmentId_fkey";

-- DropForeignKey
ALTER TABLE "Paperwork" DROP CONSTRAINT "Paperwork_shipmentId_fkey";

-- DropForeignKey
ALTER TABLE "Pickup" DROP CONSTRAINT "Pickup_shipmentId_fkey";

-- DropForeignKey
ALTER TABLE "Receiver" DROP CONSTRAINT "Receiver_locationId_fkey";

-- DropForeignKey
ALTER TABLE "Sender" DROP CONSTRAINT "Sender_locationId_fkey";

-- DropForeignKey
ALTER TABLE "ShipmentDetails" DROP CONSTRAINT "ShipmentDetails_shipmentId_fkey";

-- AddForeignKey
ALTER TABLE "Package" ADD CONSTRAINT "Package_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PalletsManagement" ADD CONSTRAINT "PalletsManagement_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Paperwork" ADD CONSTRAINT "Paperwork_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pickup" ADD CONSTRAINT "Pickup_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentDetails" ADD CONSTRAINT "ShipmentDetails_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sender" ADD CONSTRAINT "Sender_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Receiver" ADD CONSTRAINT "Receiver_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contact" ADD CONSTRAINT "Contact_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE CASCADE ON UPDATE CASCADE;
