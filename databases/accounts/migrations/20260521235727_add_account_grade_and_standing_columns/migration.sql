-- CreateEnum
CREATE TYPE "AccountStanding" AS ENUM ('HEALTHY', 'STANDARD', 'NEW', 'HYPERCARE');

-- CreateEnum
CREATE TYPE "AccountGrade" AS ENUM ('A', 'B', 'C', 'D', 'X');

-- AlterTable
ALTER TABLE "Account" ADD COLUMN     "grade" "AccountGrade",
ADD COLUMN     "standing" "AccountStanding";
