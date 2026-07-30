-- AlterTable
ALTER TABLE "User" ADD COLUMN     "homePreferenceCode" TEXT;

-- CreateTable
CREATE TABLE "HomePreference" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "HomePreference_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "HomePreference_code_key" ON "HomePreference"("code");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_homePreferenceCode_fkey" FOREIGN KEY ("homePreferenceCode") REFERENCES "HomePreference"("code") ON DELETE SET NULL ON UPDATE CASCADE;
