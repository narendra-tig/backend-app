-- CreateTable
CREATE TABLE IF NOT EXISTS "Preference" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "importType" TEXT NOT NULL,
    "userId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tenantId" UUID NOT NULL,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "Preference_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX IF NOT EXISTS "Preference_userId_tenantId_key" ON "Preference"("userId", "tenantId");

-- AddForeignKey
ALTER TABLE "Preference" ADD CONSTRAINT "Preference_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Enable RLS
ALTER TABLE "Preference" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Preference" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Preference" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Preference" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');
