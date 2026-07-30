-- AlterTable
ALTER TABLE "TenancyPreference" ADD COLUMN     "brandingTemplateId" UUID,
ADD COLUMN     "mandatoryFields" TEXT[] DEFAULT ARRAY[]::TEXT[];
