-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "TableType" ADD VALUE 'DANGEROUS_GOODS';
ALTER TYPE "TableType" ADD VALUE 'ITEMS';
ALTER TYPE "TableType" ADD VALUE 'ADDRESS_BOOK';
ALTER TYPE "TableType" ADD VALUE 'INTERNATIONAL_ITEMS';
