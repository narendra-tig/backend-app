-- CreateEnum
CREATE TYPE "WatchUntil" AS ENUM ('IS_DELIVERED', 'IS_DELIVERED_PLUS_7', 'IS_DELIVERED_PLUS_14', 'IS_CANCELLED', 'DAYS_7', 'DAYS_14', 'DAYS_30', 'DAYS_60', 'DAYS_90', 'INDEFINITELY');

-- CreateTable
CREATE TABLE "Watchlist" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "shipmentId" UUID NOT NULL,
    "notes" TEXT,
    "watchUntil" "WatchUntil" NOT NULL,
    "sendNotifications" BOOLEAN NOT NULL DEFAULT false,
    "hasUpdates" BOOLEAN DEFAULT false,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted" BOOLEAN DEFAULT false,
    "deletedDate" TIMESTAMPTZ,

    CONSTRAINT "Watchlist_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Watchlist_userId_shipmentId_idx" ON "Watchlist"("userId", "shipmentId");

-- AddForeignKey
ALTER TABLE "Watchlist" ADD CONSTRAINT "Watchlist_shipmentId_fkey" FOREIGN KEY ("shipmentId") REFERENCES "Shipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
