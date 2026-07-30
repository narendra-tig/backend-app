-- DropForeignKey
ALTER TABLE "TimedToken" DROP CONSTRAINT "TimedToken_userId_fkey";

-- AddForeignKey
ALTER TABLE "TimedToken" ADD CONSTRAINT "TimedToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
