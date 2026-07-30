-- CreateTable
CREATE TABLE "ShipmentPreference" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "serviceId" UUID,
    "carrierId" UUID,
    "connectionId" UUID,
    "defaultSenderId" UUID,
    "defaultSpecialInstructions" TEXT,
    "defaultServiceName" TEXT,
    "autoSaveAddressBookItem" BOOLEAN NOT NULL DEFAULT false,
    "internalReferenceRequired" BOOLEAN NOT NULL DEFAULT false,
    "shipmentReferenceRequired" BOOLEAN NOT NULL DEFAULT false,
    "signatureRequired" BOOLEAN NOT NULL DEFAULT false,
    "quoteReferenceRequired" BOOLEAN NOT NULL DEFAULT false,
    "enableShippingNotifications" BOOLEAN NOT NULL DEFAULT false,
    "enableConsignmentConsolidation" BOOLEAN NOT NULL DEFAULT false,
    "customerGroupId" UUID,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ShipmentPreference_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ShipmentPreference_serviceId_idx" ON "ShipmentPreference"("serviceId");

-- CreateIndex
CREATE INDEX "ShipmentPreference_carrierId_idx" ON "ShipmentPreference"("carrierId");

-- CreateIndex
CREATE INDEX "ShipmentPreference_connectionId_idx" ON "ShipmentPreference"("connectionId");

-- CreateIndex
CREATE INDEX "ShipmentPreference_defaultSenderId_idx" ON "ShipmentPreference"("defaultSenderId");

-- CreateIndex
CREATE INDEX "ShipmentPreference_customerGroupId_idx" ON "ShipmentPreference"("customerGroupId");
