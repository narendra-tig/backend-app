import type { IConnection } from './IConnection';
import * as functional from './functional';

type BoundApi<T> = T extends (
  connection: IConnection,
  ...args: infer Args
) => infer Result
  ? (...args: Args) => Result
  : T extends object
    ? { readonly [Key in keyof T]: BoundApi<T[Key]> }
    : T;

function bindConnection<T>(target: T, connection: IConnection): BoundApi<T> {
  if (typeof target === 'function') {
    return ((...args: unknown[]) =>
      (
        target as unknown as (
          connection: IConnection,
          ...args: unknown[]
        ) => unknown
      )(connection, ...args)) as BoundApi<T>;
  }

  if (typeof target !== 'object' || target === null) {
    return target as BoundApi<T>;
  }

  return Object.fromEntries(
    Object.entries(target).map(([key, value]) => [
      key,
      bindConnection(value, connection),
    ]),
  ) as BoundApi<T>;
}

function withDefaultCredentials(connection: IConnection): IConnection {
  return {
    ...connection,
    options: {
      credentials: 'include',
      ...connection.options,
    },
  };
}

export type Backend = BoundApi<typeof functional>;
export type AccountsSdk = BoundApi<typeof functional.accounts>;

export function createBackend(connection: IConnection): Backend {
  return bindConnection(functional, withDefaultCredentials(connection));
}

export function createAccounts(connection: IConnection): AccountsSdk {
  return bindConnection(
    functional.accounts,
    withDefaultCredentials(connection),
  );
}
