/*
  Warnings:

  - A unique constraint covering the columns `[authenticationName,authenticationKey,authenticationType]` on the table `AuthenticationProviderCredentials` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE "public"."UserAuthenticationProvider" DROP CONSTRAINT "UserAuthenticationProvider_userCredentialId_fkey";

-- CreateIndex
CREATE UNIQUE INDEX "AuthenticationProviderCredentials_authenticationName_authen_key" ON "public"."AuthenticationProviderCredentials"("authenticationName", "authenticationKey", "authenticationType");
