-- CreateIndex
CREATE INDEX "idx_account_role_assignment_accountId" ON "AccountRoleAssignment"("accountId");

-- CreateIndex
CREATE INDEX "idx_account_role_mapping_accountId" ON "AccountRoleMapping"("accountId");

-- CreateIndex
CREATE INDEX "idx_note_accountId" ON "Note"("accountId");
