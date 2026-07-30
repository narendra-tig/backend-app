-- CreateTable
CREATE TABLE "EmailTemplateSetting" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "subject" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "tenantId" UUID NOT NULL,
    "customerGroupId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "EmailTemplateSetting_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "EmailTemplateSetting" ADD CONSTRAINT "EmailTemplateSetting_customerGroupId_fkey" FOREIGN KEY ("customerGroupId") REFERENCES "CustomerGroupSettings"("customerGroupId") ON DELETE CASCADE ON UPDATE CASCADE;

CREATE UNIQUE INDEX "EmailTemplateSetting_customerGroupId_subject_key" ON "EmailTemplateSetting"("customerGroupId", "subject");
