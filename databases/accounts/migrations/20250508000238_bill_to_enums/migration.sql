/*
  Warnings:

  - The `billTo` column on the `Receiver` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "ReceiverBillTo" AS ENUM ('NONE', 'RECEIVER_PAYS', 'THIRD_PARTY_ACCT');

-- AlterTable
ALTER TABLE "Receiver" DROP COLUMN "billTo",
ADD COLUMN     "billTo" "ReceiverBillTo" DEFAULT 'NONE';
