/*
  Warnings:

  - The values [GET_QUOTE,CREATE_SHIPMENT] on the enum `Command` will be removed. If these variants are still used in the database, this will fail.
  - The values [ACCEPTED,STARTED,COMPLETED,FAILED] on the enum `Status` will be removed. If these variants are still used in the database, this will fail.

*/
-- CreateEnum
CREATE TYPE "ShipmentStatus" AS ENUM ('DRAFT', 'READY_TO_SHIP', 'MANIFESTED', 'HELD', 'CANCELLED', 'DELIVERED');

-- CreateEnum
CREATE TYPE "SignaturePreference" AS ENUM ('SIGNATURE_REQUIRED', 'AUTHORITY_TO_LEAVE');

-- AlterEnum
BEGIN;
CREATE TYPE "Command_new" AS ENUM ('get_quote', 'create_shipment');
ALTER TABLE "Job" ALTER COLUMN "type" TYPE "Command_new" USING ("type"::text::"Command_new");
ALTER TYPE "Command" RENAME TO "Command_old";
ALTER TYPE "Command_new" RENAME TO "Command";
DROP TYPE "Command_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "Status_new" AS ENUM ('accepted', 'started', 'completed', 'failed');
ALTER TABLE "Job" ALTER COLUMN "status" TYPE "Status_new" USING ("status"::text::"Status_new");
ALTER TABLE "Task" ALTER COLUMN "status" TYPE "Status_new" USING ("status"::text::"Status_new");
ALTER TYPE "Status" RENAME TO "Status_old";
ALTER TYPE "Status_new" RENAME TO "Status";
DROP TYPE "Status_old";
COMMIT;

-- CreateTable
CREATE TABLE "TaskQuoteResult" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "priceTotal" MONEY NOT NULL,
    "tax" MONEY NOT NULL,
    "price" MONEY NOT NULL,
    "taskId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,

    CONSTRAINT "TaskQuoteResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Shipment" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "reference" TEXT NOT NULL,
    "senderId" UUID NOT NULL,
    "receiverId" UUID NOT NULL,
    "dispatchDate" TIMESTAMPTZ NOT NULL,
    "signaturePreference" "SignaturePreference" NOT NULL,
    "billTo" TEXT NOT NULL,
    "carrierId" UUID NOT NULL,
    "serviceId" UUID NOT NULL,
    "pickupInstructions" TEXT,
    "deliveryInstructions" TEXT,
    "customReference" TEXT,
    "status" "ShipmentStatus" NOT NULL,
    "pickupId" UUID,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "packageId" UUID,

    CONSTRAINT "Shipment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Package" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "packageType" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "weight" DECIMAL(65,30) NOT NULL,
    "length" DECIMAL(65,30) NOT NULL,
    "width" DECIMAL(65,30) NOT NULL,
    "height" DECIMAL(65,30) NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "shipmentId" UUID NOT NULL,

    CONSTRAINT "Package_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PalletsManagement" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "accountNumber" TEXT NOT NULL,
    "chep" INTEGER NOT NULL,
    "loscam" INTEGER NOT NULL,
    "other" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "shipmentId" UUID NOT NULL,

    CONSTRAINT "PalletsManagement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Paperwork" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "fileName" TEXT NOT NULL,
    "size" BIGINT NOT NULL,
    "reference" TEXT NOT NULL,
    "tag" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "shipmentId" UUID NOT NULL,

    CONSTRAINT "Paperwork_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pickup" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "pickupDate" TIMESTAMP(3) NOT NULL,
    "readyTime" TIMESTAMP(3) NOT NULL,
    "closingTime" TIMESTAMP(3) NOT NULL,
    "timezone" TEXT NOT NULL,
    "internalReference" TEXT NOT NULL,
    "pickupArea" TEXT NOT NULL,
    "specialInstructions" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "shipmentId" UUID NOT NULL,

    CONSTRAINT "Pickup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ShipmentDetails" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "dispatchDate" TEXT NOT NULL,
    "deliverySignaturePreference" "SignaturePreference" NOT NULL,
    "billTo" TEXT NOT NULL,
    "carrier" TEXT NOT NULL,
    "carrierService" TEXT NOT NULL,
    "specialServices" TEXT[],
    "pickupInstructions" TEXT,
    "deliveryInstructions" TEXT,
    "customReference" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "shipmentId" UUID NOT NULL,

    CONSTRAINT "ShipmentDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sender" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "customerGroupId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "locationId" UUID NOT NULL,

    CONSTRAINT "Sender_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Receiver" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "locationId" UUID NOT NULL,
    "specialInstructions" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,

    CONSTRAINT "Receiver_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Location" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "addressId" UUID NOT NULL,

    CONSTRAINT "Location_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Address" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "addressLine1" TEXT NOT NULL,
    "addressLine2" TEXT,
    "citySuburbTown" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "postcode" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contact" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "locationId" UUID NOT NULL,

    CONSTRAINT "Contact_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PalletsManagement_shipmentId_key" ON "PalletsManagement"("shipmentId");

-- CreateIndex
CREATE UNIQUE INDEX "Pickup_shipmentId_key" ON "Pickup"("shipmentId");

-- CreateIndex
CREATE UNIQUE INDEX "ShipmentDetails_shipmentId_key" ON "ShipmentDetails"("shipmentId");

-- CreateIndex
CREATE UNIQUE INDEX "Sender_locationId_key" ON "Sender"("locationId");

-- CreateIndex
CREATE UNIQUE INDEX "Receiver_locationId_key" ON "Receiver"("locationId");

-- CreateIndex
CREATE UNIQUE INDEX "Location_addressId_key" ON "Location"("addressId");

-- CreateIndex
CREATE UNIQUE INDEX "Contact_locationId_key" ON "Contact"("locationId");

-- AddForeignKey
ALTER TABLE "TaskQuoteResult" ADD CONSTRAINT "TaskQuoteResult_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Shipment" ADD CONSTRAINT "Shipment_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "Sender"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Shipment" ADD CONSTRAINT "Shipment_receiverId_fkey" FOREIGN KEY ("receiverId") REFERENCES "Receiver"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Package" ADD CONSTRAINT "Package_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PalletsManagement" ADD CONSTRAINT "PalletsManagement_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Paperwork" ADD CONSTRAINT "Paperwork_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pickup" ADD CONSTRAINT "Pickup_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ShipmentDetails" ADD CONSTRAINT "ShipmentDetails_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sender" ADD CONSTRAINT "Sender_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Receiver" ADD CONSTRAINT "Receiver_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Location" ADD CONSTRAINT "Location_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contact" ADD CONSTRAINT "Contact_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
