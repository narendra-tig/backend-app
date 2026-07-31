ALTER TABLE "TrackingEvent" ADD COLUMN "replayKey" TEXT;

UPDATE "TrackingEvent" SET "replayKey" = "id"::text;

ALTER TABLE "TrackingEvent" ALTER COLUMN "replayKey" SET NOT NULL;

CREATE UNIQUE INDEX "TrackingEvent_replayKey_key" ON "TrackingEvent"("replayKey");