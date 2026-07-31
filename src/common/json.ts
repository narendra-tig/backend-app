import type { JsonValue } from '../contracts';

export function toJsonValue(value: unknown): JsonValue | undefined {
  if (value === undefined) return undefined;
  return JSON.parse(JSON.stringify(value)) as JsonValue;
}

export function compact<T extends object>(value: T): T {
  return Object.fromEntries(
    Object.entries(value).filter(([, entry]) => entry !== undefined),
  ) as T;
}

export function toOptional<T>(value: T | null | undefined): T | undefined {
  return value ?? undefined;
}

export function toDecimalString(
  value: { toString(): string } | number | null | undefined,
): string | undefined {
  return value === null || value === undefined ? undefined : value.toString();
}
