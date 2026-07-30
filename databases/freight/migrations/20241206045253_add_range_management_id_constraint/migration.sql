-- this migration adds a constraint to the RangeManagementId table to ensure that the currentId is within the range of start and end

ALTER TABLE "RangeManagementId" ADD CONSTRAINT "validRange" CHECK ("startId" <= "currentId" AND "currentId" <= "endId");