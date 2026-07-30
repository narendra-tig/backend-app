-- AlterTable
ALTER TABLE "CustomerGroupSettings" ADD COLUMN     "isEmailEnabled" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifyReceiverDelivered" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifyReceiverManifested" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifyReceiverOnboard" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifyReceiverPod" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifyReceiverProblem" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifyReceiverTransitDelay" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifySenderDelivered" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifySenderManifested" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifySenderOnboard" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifySenderPod" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifySenderProblem" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "notifySenderTransitDelay" BOOLEAN NOT NULL DEFAULT false;
