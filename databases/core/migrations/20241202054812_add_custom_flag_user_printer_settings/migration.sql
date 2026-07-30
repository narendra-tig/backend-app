-- AlterTable
ALTER TABLE "PrinterSetting" ADD COLUMN     "isCustom" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "_ConnectionToPermission" ADD CONSTRAINT "_ConnectionToPermission_AB_pkey" PRIMARY KEY ("A", "B");

-- DropIndex
DROP INDEX "_ConnectionToPermission_AB_unique";

-- AlterTable
ALTER TABLE "_ConnectionToRole" ADD CONSTRAINT "_ConnectionToRole_AB_pkey" PRIMARY KEY ("A", "B");

-- DropIndex
DROP INDEX "_ConnectionToRole_AB_unique";

-- AlterTable
ALTER TABLE "_PermissionToRole" ADD CONSTRAINT "_PermissionToRole_AB_pkey" PRIMARY KEY ("A", "B");

-- DropIndex
DROP INDEX "_PermissionToRole_AB_unique";
