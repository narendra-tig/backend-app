# Open360 backend app

A NestJS modular monolith that exposes the account, tenancy, shipment, public tracking, return, carrier, location, enquiry, and tracking-service contracts through Nestia-generated SDK functions.

## Architecture

Database providers are deliberately **not global**. Each bounded feature imports only the database module it owns or reads:

| Feature module | Database modules |
| --- | --- |
| Accounts | Accounts |
| Tenancy | Accounts, Core |
| Shipments | Freight |
| Tracking service | Freight, Tracking |
| Returns | Freight |
| Carriers | Freight |
| Locations | Freight |
| Enquiries | Accounts, Freight through Shipments |
| Tracking facade | Composes exported feature services; no direct database provider |

This keeps dependencies visible, prevents unrelated Prisma clients from being created for a feature, and makes provider overrides straightforward in tests.

## Authorization boundaries

- Tenant/account/shipment management calls verify the existing Open360 HS256 session JWT (Bearer token or environment auth cookie) and require its `context.tenantId` to match `x-tenant-id`.
- `/v1/tracking-service/**` is service-to-service only and requires `x-internal-api-key`. Supply `internalApiKey` to `createBackend` for its SDK methods.
- Shipment-by-reference, account-by-name, carrier package types, and the public tracking facade remain public for compatibility with the original tracking API. Shipment references therefore remain access secrets and should be high entropy; place rate limiting/WAF controls in front of these routes.
- Return retrieval and booking require the signed, expiring validation token in `x-return-token`; Nestia exposes this as the endpoint header argument.

## API groups

- `/v1/accounts`
- `/v1/tenancy`
- `/v1/shipments`
- `/v1/tracking/shipments`
- `/v1/tracking/returns`
- `/v1/tracking/enquiries`
- `/v1/tracking-service`
- `/v1/carriers`
- `/v1/locations`

The service-level tracking routes implement the original eight tracking-service operations: event reads/writes, account shipment tracking, polling, delivered status, registration, shipment tracking, and notified-event persistence.

## SDK

Nestia generates transport functions under `api/functional`. The checked-in `api/backend.ts` adds connection-bound classes:

- `Open360Sdk`
- `AccountsSdk`
- `TenancySdk`
- `ShipmentsSdk`
- `TrackingSdk`
- `TrackingServiceSdk`
- `CarriersSdk`
- `LocationsSdk`

Create a client with `createBackend({ host, tenantId, authorization })`. Tenant-scoped calls automatically receive `x-tenant-id`.

## Environment

Copy `.env.example` and configure the Accounts, Core, Documents, Freight, and Tracking PostgreSQL URLs. `HELP_DESK_SERVICE_URL` is required only for tracking enquiry submission.

`TRACKING_ENQUIRIES_SECRET_KEY` and `INTERNAL_API_KEY` must be long random secrets. Production fails closed when token secrets are absent.

The help-desk client uses the original gRPC contract. Local development may set `HELP_DESK_GRPC_INSECURE=true`; non-local environments require `HELP_DESK_GRPC_CA_PATH` for TLS. `NOTIFICATIONS_TRACKING_URL` enables the original manifested/onboard/delivered notification dispatch.

## Commands

- `pnpm run build` — regenerate SDK, then compile the server with Nestia's `ttsc` transformer.
- `pnpm run start` — run TypeScript through Nestia's `ttsx` runner.
- `pnpm run start:prod` — run transformed output.
- `pnpm run nestia:sdk` — regenerate functional SDK contracts.
- `pnpm run nestia:swagger` — regenerate OpenAPI 3.1 at `swagger/swagger.json`.
- `pnpm run sdk:build` — regenerate and compile the publishable SDK package.
- `pnpm run lint` — lint source and tests.
- `pnpm run test` — unit tests.
- `pnpm run test:e2e` — e2e tests with bounded Prisma providers overridden.

Do not replace `ttsc`/`ttsx` with stock `tsc`, `ts-node`, or `nest build`; Nestia typed decorators require their compile-time transformer.
