-- CreateTable
CREATE TABLE "SystemUser" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "accountId" UUID,
    "tenantId" UUID NOT NULL,
    "systemUserId" UUID NOT NULL,
    "type" "UserType" NOT NULL,
    "systemUserEmail" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SystemUser_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "SystemUser" ADD CONSTRAINT "SystemUser_systemUserId_fkey" FOREIGN KEY ("systemUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "SystemUser" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "SystemUser" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "SystemUser" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "SystemUser" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');