import { createHmac, timingSafeEqual } from 'node:crypto';

function secret(): string {
  const configured =
    process.env.TRACKING_ENQUIRIES_SECRET_KEY ?? process.env.TOKEN_JWT_SECRET;
  if (configured) return configured;
  if (process.env.NODE_ENV === 'test' || process.env.ENV === 'local') {
    return 'local-development-only-secret';
  }
  throw new Error('TRACKING_ENQUIRIES_SECRET_KEY is not configured');
}

export function signTrackingValue(value: string): string {
  return createHmac('sha256', secret()).update(value).digest('hex');
}

export function verifyTrackingValue(value: string, token: string): boolean {
  const expected = Buffer.from(signTrackingValue(value));
  const actual = Buffer.from(token);
  return expected.length === actual.length && timingSafeEqual(expected, actual);
}

export function verifyReturnToken(
  token: string,
  shipmentId: string,
  returnCode: string,
): boolean {
  const separator = token.lastIndexOf('.');
  if (separator < 0) return false;
  const payload = token.slice(0, separator);
  const signature = token.slice(separator + 1);
  if (!verifyTrackingValue(payload, signature)) return false;

  const [tokenShipmentId, tokenReturnCode, expiresAt] = payload.split('.');
  if (tokenShipmentId !== shipmentId || tokenReturnCode !== returnCode) {
    return false;
  }
  const expiration = Number(expiresAt);
  return (
    Number.isFinite(expiration) && expiration > Math.floor(Date.now() / 1000)
  );
}

export function readReturnToken(token: string): {
  shipmentId: string;
  returnCode: string;
} | null {
  const separator = token.lastIndexOf('.');
  if (separator < 0) return null;
  const payload = token.slice(0, separator);
  const signature = token.slice(separator + 1);
  if (!verifyTrackingValue(payload, signature)) return null;
  const [shipmentId, returnCode, expiresAt] = payload.split('.');
  const expiration = Number(expiresAt);
  if (
    !shipmentId ||
    !returnCode ||
    !Number.isFinite(expiration) ||
    expiration <= Math.floor(Date.now() / 1000)
  ) {
    return null;
  }
  return { shipmentId, returnCode };
}

export function currentTrackingWindow(reference: string): string {
  const parts = new Intl.DateTimeFormat('en-CA', {
    timeZone: 'Australia/Sydney',
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    hourCycle: 'h23',
  }).formatToParts(new Date());
  const get = (type: Intl.DateTimeFormatPartTypes) =>
    parts.find((part) => part.type === type)?.value ?? '';
  return `${reference}${get('year')}-${get('month')}-${Number(get('day'))}${get('hour')}`;
}
