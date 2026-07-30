-- CreateEnum
CREATE TYPE "Status" AS ENUM ('ACCEPTED', 'STARTED', 'COMPLETED', 'FAILED');

-- CreateEnum
CREATE TYPE "Command" AS ENUM ('GET_QUOTE', 'CREATE_SHIPMENT');

-- CreateTable
CREATE TABLE "Job" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "deadline" TIMESTAMPTZ NOT NULL,
    "status" "Status" NOT NULL,
    "type" "Command" NOT NULL,
    "accountId" UUID NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,

    CONSTRAINT "Job_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Task" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "carrier" TEXT NOT NULL,
    "status" "Status" NOT NULL,
    "tenantId" UUID NOT NULL DEFAULT (current_setting('app.tenant_id'::text))::uuid,
    "jobId" UUID NOT NULL,

    CONSTRAINT "Task_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Task_carrier_jobId_key" ON "Task"("carrier", "jobId");

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- ENABLE RLS

ALTER TABLE "Job" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Job" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Job" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Job" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');

ALTER TABLE "Task" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "Task" FORCE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation_policy ON "Task" USING ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid) WITH CHECK ("tenantId" = (NULLIF(current_setting('app.tenant_id'::text, true), ''::text))::uuid);
CREATE POLICY bypass_rls_policy ON "Task" USING (current_setting('app.bypass_rls', TRUE)::text = 'on');
