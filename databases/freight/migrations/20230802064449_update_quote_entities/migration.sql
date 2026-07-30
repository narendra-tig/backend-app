/*
  Warnings:

  - The values [get_quote,create_shipment] on the enum `Command` will be removed. If these variants are still used in the database, this will fail.
  - The values [accepted,started,completed,failed] on the enum `Status` will be removed. If these variants are still used in the database, this will fail.
  - Added the required column `updatedAt` to the `Job` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Task` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "Command_new" AS ENUM ('GET_QUOTE', 'CREATE_SHIPMENT');
ALTER TABLE "Job" ALTER COLUMN "type" TYPE "Command_new" USING ("type"::text::"Command_new");
ALTER TYPE "Command" RENAME TO "Command_old";
ALTER TYPE "Command_new" RENAME TO "Command";
DROP TYPE "Command_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "Status_new" AS ENUM ('ACCEPTED', 'STARTED', 'COMPLETED', 'FAILED');
ALTER TABLE "Job" ALTER COLUMN "status" TYPE "Status_new" USING ("status"::text::"Status_new");
ALTER TABLE "Task" ALTER COLUMN "status" TYPE "Status_new" USING ("status"::text::"Status_new");
ALTER TYPE "Status" RENAME TO "Status_old";
ALTER TYPE "Status_new" RENAME TO "Status";
DROP TYPE "Status_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "Task" DROP CONSTRAINT "Task_jobId_fkey";

-- DropForeignKey
ALTER TABLE "TaskQuoteResult" DROP CONSTRAINT "TaskQuoteResult_taskId_fkey";

-- AlterTable
ALTER TABLE "Job" ADD COLUMN     "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Task" ADD COLUMN     "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "TaskQuoteResult" ADD COLUMN     "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaskQuoteResult" ADD CONSTRAINT "TaskQuoteResult_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE CASCADE ON UPDATE CASCADE;
