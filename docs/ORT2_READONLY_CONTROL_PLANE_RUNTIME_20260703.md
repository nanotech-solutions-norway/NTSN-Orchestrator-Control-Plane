# O-RT2 Read-only Control Plane Runtime — 2026-07-03

## Release train

```text
O-RT2 — Read-only Control Plane Runtime
```

## Classification

```text
READ_ONLY_READY
PLAN_ONLY_READY
CONTROLLED_WRITE_PENDING_APPROVAL
LIVE_WRITE_NOT_APPROVED
GET_ONLY_RUNTIME_CONTRACT
```

## Purpose

O-RT2 defines the read-only runtime surface for the NTSN Orchestrator Control Plane. This release train exposes safe introspection routes for registry, route map, capability matrix, dependency graph, release status, validation status, and provider boundary map.

It does not implement or approve provider writes, DNS writes, FTP/SFTP writes, SQL writes, accounting writes, production deployment, destructive operations, bulk sync/delete, or direct provider publish actions.

## Runtime source files

```text
config/read-only-routes.yml
openapi/orchestrator-readonly.openapi.json
tests/Test-OrchestratorReadOnlyRuntime.ps1
tests/Test-OrchestratorOpenApiGetOnly.ps1
```

## Read-only endpoints

| Endpoint | Method | Purpose | Source |
|---|---|---|---|
| `/orchestrator/v1/status` | GET | Runtime/release status and global write gates | `config/evidence-status.yml` |
| `/orchestrator/v1/registry` | GET | Canonical registry readout | `config/orchestrator-registry.json` |
| `/orchestrator/v1/route-map` | GET | Read-only route map | `config/read-only-routes.yml` |
| `/orchestrator/v1/capability-matrix` | GET | Capability class and decision matrix | `config/orchestrator-registry.json` |
| `/orchestrator/v1/dependency-graph` | GET | Managed repo/provider/runtime dependency graph | `config/repositories.yml`, `config/provider-boundary.yml` |
| `/orchestrator/v1/provider-boundary` | GET | Provider boundary map | `config/provider-boundary.yml` |
| `/orchestrator/v1/evidence-status` | GET | Evidence status tracker | `config/evidence-status.yml` |
| `/orchestrator/v1/validation-status` | GET | Validation reports and pending review state | `docs/validation/*.md`, `docs/PENDING_REVIEW_ITEMS_ORT1_20260703.md` |
| `/orchestrator/v1/pending-review` | GET | Pending review register | `docs/PENDING_REVIEW_ITEMS_ORT1_20260703.md` |
| `/orchestrator/v1/openapi` | GET | OpenAPI schema for this read-only runtime | `openapi/orchestrator-readonly.openapi.json` |

## Required endpoint behavior

Every endpoint must:

1. use `GET` only;
2. return no secrets, tokens, bearer values, private customer data, database row data, private payloads, or full `.env` values;
3. include evidence provenance or source-file references;
4. return `NOT_CONFIGURED` or `PENDING_REVIEW` for unknown, stale, conflicting, or unapproved capabilities;
5. preserve all global write gates as false;
6. never call downstream provider mutation routes.

## Blocked methods

The following methods are not exposed in O-RT2:

```text
POST
PUT
PATCH
DELETE
```

Any future write or mutation route must be handled in later release trains through controlled write approval and PR-first governance. It is not part of O-RT2.

## Unknown action behavior

Unknown, unconfigured, stale, or conflicting actions must resolve to one of:

```text
NOT_CONFIGURED
PENDING_REVIEW
CONTROLLED_WRITE_PENDING_APPROVAL
```

They must not be silently promoted to `READ_ONLY_READY` or `LIVE_WRITE_APPROVED`.

## Acceptance criteria

| Criterion | Status |
|---|---|
| GET-only schema exists | Complete |
| Every capability has status and source | Complete by registry reference |
| Unknown actions default to `NOT_CONFIGURED` or `PENDING_REVIEW` | Complete |
| Provider writes remain blocked | Complete |
| Validation tests exist | Complete |

## Next release train

Proceed next with:

```text
O-RT3 — Plan-only Orchestration Engine
```

O-RT3 may generate executable-looking plans, but it must not execute them. It must compile pre-checks, required evidence, approval class, target MCP, payload shape, rollback plan, and validation steps.
