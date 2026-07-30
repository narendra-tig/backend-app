-- CreateTable
CREATE TABLE "_OrganisationalUnitToPermission" (
    "A" UUID NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_OrganisationalUnitToPermission_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_OrganisationalUnitToPermission_B_index" ON "_OrganisationalUnitToPermission"("B");

-- AddForeignKey
ALTER TABLE "_OrganisationalUnitToPermission" ADD CONSTRAINT "_OrganisationalUnitToPermission_A_fkey" FOREIGN KEY ("A") REFERENCES "OrganisationalUnit"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OrganisationalUnitToPermission" ADD CONSTRAINT "_OrganisationalUnitToPermission_B_fkey" FOREIGN KEY ("B") REFERENCES "Permission"("name") ON DELETE CASCADE ON UPDATE CASCADE;
