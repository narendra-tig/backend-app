import type { IConnection } from './IConnection';
import * as functional from './functional';

export interface Open360SdkOptions {
  host: string;
  tenantId?: string;
  accountId?: string;
  internalApiKey?: string;
  authorization?: string;
  headers?: Record<string, string>;
  credentials?: 'omit' | 'same-origin' | 'include';
}

function createConnection(options: Open360SdkOptions): IConnection {
  return {
    host: options.host,
    headers: {
      ...options.headers,
      ...(options.tenantId ? { 'x-tenant-id': options.tenantId } : {}),
      ...(options.accountId ? { 'x-account-id': options.accountId } : {}),
      ...(options.internalApiKey
        ? { 'x-internal-api-key': options.internalApiKey }
        : {}),
      ...(options.authorization
        ? { authorization: options.authorization }
        : {}),
    },
    options: {
      credentials: options.credentials ?? 'include',
    },
  };
}

export class AccountsSdk {
  constructor(private readonly connection: IConnection) {}

  list = (...args: Tail<Parameters<typeof functional.v1.accounts.list>>) =>
    functional.v1.accounts.list(this.connection, ...args);
  findOne = (
    ...args: Tail<Parameters<typeof functional.v1.accounts.findOne>>
  ) => functional.v1.accounts.findOne(this.connection, ...args);
  findByName = (
    ...args: Tail<
      Parameters<typeof functional.v1.accounts.by_name.findByName>
    >
  ) => functional.v1.accounts.by_name.findByName(this.connection, ...args);
  update = (...args: Tail<Parameters<typeof functional.v1.accounts.update>>) =>
    functional.v1.accounts.update(this.connection, ...args);
}

export class TenancySdk {
  constructor(private readonly connection: IConnection) {}

  getTenant = (
    ...args: Tail<Parameters<typeof functional.v1.tenancy.tenant.getTenant>>
  ) => functional.v1.tenancy.tenant.getTenant(this.connection, ...args);
  getContext = (
    ...args: Tail<Parameters<typeof functional.v1.tenancy.context.getContext>>
  ) => functional.v1.tenancy.context.getContext(this.connection, ...args);
  listUsers = (
    ...args: Tail<Parameters<typeof functional.v1.tenancy.users.listUsers>>
  ) => functional.v1.tenancy.users.listUsers(this.connection, ...args);
  verifyAccountAccess = (
    ...args: Tail<
      Parameters<
        typeof functional.v1.tenancy.accounts.access.verifyAccountAccess
      >
    >
  ) =>
    functional.v1.tenancy.accounts.access.verifyAccountAccess(
      this.connection,
      ...args,
    );
}

export class ShipmentsSdk {
  constructor(private readonly connection: IConnection) {}

  list = (...args: Tail<Parameters<typeof functional.v1.shipments.list>>) =>
    functional.v1.shipments.list(this.connection, ...args);
  findById = (
    ...args: Tail<Parameters<typeof functional.v1.shipments.findById>>
  ) => functional.v1.shipments.findById(this.connection, ...args);
  findByReference = (
    ...args: Tail<
      Parameters<typeof functional.v1.shipments.by_reference.findByReference>
    >
  ) =>
    functional.v1.shipments.by_reference.findByReference(
      this.connection,
      ...args,
    );
}

export class TrackingSdk {
  constructor(private readonly connection: IConnection) {}

  findShipmentByReference = (
    ...args: Tail<
      Parameters<
        typeof functional.v1.tracking.shipments.by_reference.findByReference
      >
    >
  ) =>
    functional.v1.tracking.shipments.by_reference.findByReference(
      this.connection,
      ...args,
    );
  getShipmentEvents = (
    ...args: Tail<
      Parameters<typeof functional.v1.tracking.shipments.events.getEvents>
    >
  ) =>
    functional.v1.tracking.shipments.events.getEvents(
      this.connection,
      ...args,
    );
  getReturnShipment = (
    ...args: Tail<Parameters<typeof functional.v1.tracking.returns.findByCode>>
  ) => functional.v1.tracking.returns.findByCode(this.connection, ...args);
  validateReturn = (
    ...args: Tail<Parameters<typeof functional.v1.tracking.returns.validate>>
  ) => functional.v1.tracking.returns.validate(this.connection, ...args);
  bookReturn = (
    ...args: Tail<Parameters<typeof functional.v1.tracking.returns.book>>
  ) => functional.v1.tracking.returns.book(this.connection, ...args);
  getEnquiryTypes = (
    ...args: Tail<
      Parameters<typeof functional.v1.tracking.enquiries.types.getTypes>
    >
  ) => functional.v1.tracking.enquiries.types.getTypes(this.connection, ...args);
  createEnquiry = (
    ...args: Tail<Parameters<typeof functional.v1.tracking.enquiries.create>>
  ) => functional.v1.tracking.enquiries.create(this.connection, ...args);
}

export class TrackingServiceSdk {
  constructor(private readonly connection: IConnection) {}

  getTrackingEvents = (
    ...args: Tail<
      Parameters<
        typeof functional.v1.tracking_service.shipments.events.getTrackingEvents
      >
    >
  ) =>
    functional.v1.tracking_service.shipments.events.getTrackingEvents(
      this.connection,
      ...args,
    );
  saveTrackingEvents = (
    ...args: Tail<
      Parameters<
        typeof functional.v1.tracking_service.events.saveTrackingEvents
      >
    >
  ) =>
    functional.v1.tracking_service.events.saveTrackingEvents(
      this.connection,
      ...args,
    );
  getShipmentsTracking = (
    ...args: Tail<
      Parameters<
        typeof functional.v1.tracking_service.accounts.shipments.getShipmentsTracking
      >
    >
  ) =>
    functional.v1.tracking_service.accounts.shipments.getShipmentsTracking(
      this.connection,
      ...args,
    );
  getShipmentsForTracking = (
    ...args: Tail<
      Parameters<
        typeof functional.v1.tracking_service.poll.getShipmentsForTracking
      >
    >
  ) =>
    functional.v1.tracking_service.poll.getShipmentsForTracking(
      this.connection,
      ...args,
    );
  registerTrackingShipment = (
    ...args: Tail<
      Parameters<
        typeof functional.v1.tracking_service.shipments.registerTrackingShipment
      >
    >
  ) =>
    functional.v1.tracking_service.shipments.registerTrackingShipment(
      this.connection,
      ...args,
    );
  getShipmentTracking = (
    ...args: Tail<
      Parameters<
        typeof functional.v1.tracking_service.shipments.getShipmentTracking
      >
    >
  ) =>
    functional.v1.tracking_service.shipments.getShipmentTracking(
      this.connection,
      ...args,
    );
  updateDeliveredShipment = (
    ...args: Tail<
      Parameters<
        typeof functional.v1.tracking_service.shipments.delivery.updateDeliveredShipment
      >
    >
  ) =>
    functional.v1.tracking_service.shipments.delivery.updateDeliveredShipment(
      this.connection,
      ...args,
    );
  saveNotifiedEvent = (
    ...args: Tail<
      Parameters<
        typeof functional.v1.tracking_service.shipments.notified_events.saveNotifiedEvent
      >
    >
  ) =>
    functional.v1.tracking_service.shipments.notified_events.saveNotifiedEvent(
      this.connection,
      ...args,
    );
}

export class CarriersSdk {
  constructor(private readonly connection: IConnection) {}

  getPackageTypes = (
    ...args: Tail<
      Parameters<typeof functional.v1.carriers.package_types.getPackageTypes>
    >
  ) =>
    functional.v1.carriers.package_types.getPackageTypes(
      this.connection,
      ...args,
    );
  findByName = (
    ...args: Tail<Parameters<typeof functional.v1.carriers.by_name.findByName>>
  ) => functional.v1.carriers.by_name.findByName(this.connection, ...args);
}

export class LocationsSdk {
  constructor(private readonly connection: IConnection) {}

  search = (...args: Tail<Parameters<typeof functional.v1.locations.search>>) =>
    functional.v1.locations.search(this.connection, ...args);
}

export class Open360Sdk {
  readonly accounts: AccountsSdk;
  readonly tenancy: TenancySdk;
  readonly shipments: ShipmentsSdk;
  readonly tracking: TrackingSdk;
  readonly trackingService: TrackingServiceSdk;
  readonly carriers: CarriersSdk;
  readonly locations: LocationsSdk;

  constructor(readonly connection: IConnection) {
    this.accounts = new AccountsSdk(connection);
    this.tenancy = new TenancySdk(connection);
    this.shipments = new ShipmentsSdk(connection);
    this.tracking = new TrackingSdk(connection);
    this.trackingService = new TrackingServiceSdk(connection);
    this.carriers = new CarriersSdk(connection);
    this.locations = new LocationsSdk(connection);
  }

  health = (...args: Tail<Parameters<typeof functional.health>>) =>
    functional.health(this.connection, ...args);
}

export function createBackend(options: Open360SdkOptions): Open360Sdk {
  return new Open360Sdk(createConnection(options));
}

export function createAccounts(options: Open360SdkOptions): AccountsSdk {
  return createBackend(options).accounts;
}

export function createTracking(options: Open360SdkOptions): TrackingSdk {
  return createBackend(options).tracking;
}

export function createTrackingService(
  options: Open360SdkOptions,
): TrackingServiceSdk {
  return createBackend(options).trackingService;
}

type Tail<T extends readonly unknown[]> = T extends readonly [unknown, ...infer R]
  ? R
  : never;
