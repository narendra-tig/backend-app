-- CreateTable
CREATE TABLE "Shipment" (
    "shipmentId" UUID NOT NULL,
    "carrier" TEXT,
    "consignmentId" TEXT,
    "isDelivered" BOOLEAN NOT NULL DEFAULT false,
    "notifiedEvents" TEXT[],
    "connectionId" UUID NOT NULL,
    "accountId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Shipment_pkey" PRIMARY KEY ("shipmentId")
);

-- CreateTable
CREATE TABLE "TrackingEvent" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "location" TEXT NOT NULL,
    "packageRef" TEXT,
    "consignment" TEXT,
    "trackingEventId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "shipmentId" UUID NOT NULL,

    CONSTRAINT "TrackingEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Shipment_shipmentId_key" ON "Shipment"("shipmentId");

-- AddForeignKey
ALTER TABLE "TrackingEvent" ADD CONSTRAINT "TrackingEvent_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("shipmentId") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Shipment" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Shipment" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Shipment" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Shipment" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "TrackingEvent" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "TrackingEvent" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "TrackingEvent" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "TrackingEvent" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');
