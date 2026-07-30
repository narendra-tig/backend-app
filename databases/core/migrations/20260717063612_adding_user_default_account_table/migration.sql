-- CreateTable
CREATE TABLE "UserDefaultAccount" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "userId" UUID NOT NULL,
    "accountId" UUID NOT NULL,
    "tenantId" UUID NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserDefaultAccount_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_user_default_account_userId" ON "UserDefaultAccount"("userId");

-- CreateIndex
CREATE INDEX "idx_user_default_account_tenantId_userId" ON "UserDefaultAccount"("tenantId", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "UserDefaultAccount_userId_accountId_key" ON "UserDefaultAccount"("userId", "accountId");

-- CreateIndex
CREATE INDEX "idx_connection_userId" ON "Connection"("userId");

-- CreateIndex
CREATE INDEX "idx_connection_tenantId_userId" ON "Connection"("tenantId", "userId");

-- CreateIndex
CREATE INDEX "idx_connection_tenantId_userId_organisationalUnitId" ON "Connection"("tenantId", "userId", "organisationalUnitId");

-- AddForeignKey
ALTER TABLE "UserDefaultAccount" ADD CONSTRAINT "UserDefaultAccount_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
