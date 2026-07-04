# O-RT6 Provider Adapter Control Layer — 2026-07-03

## Release train

```text
O-RT6 — Provider Adapter Control Layer
```

## Classification

```text
PROVIDER_ADAPTER_CONTRACT
READ_ONLY_READY
PLAN_ONLY_READY
CONTROLLED_WRITE_PENDING_APPROVAL
LIVE_WRITE_NOT_APPROVED
ADAPTER_BYPASS_NOT_ALLOWED
```

## Purpose

O-RT6 defines a static provider-adapter control layer for the NTSN Orchestrator Control Plane. Each downstream provider or MCP-facing adapter must advertise its capabilities, approval requirements, forbidden action categories, dry-run support, and audit behavior before the orchestrator may route plans through it.

O-RT6 does not approve live provider writes or production changes. It only defines adapter contracts and tests that prevent adapters from exceeding their declared capability or approval state.

## Required source files

```text
config/provider-adapters.yml
schemas/provider-adapter.schema.json
templates/provider-adapter/PROVIDER_ADAPTER_CONTRACT_TEMPLATE.md
examples/provider-adapters/sample_readonly_provider_adapter.json
tests/Test-OrchestratorProviderAdapterContracts.ps1
tests/Test-OrchestratorAdapterNoBypass.ps1
```

## Adapter contract requirements

Each adapter must declare:

| Field | Requirement |
|---|---|
| `adapterId` | Stable adapter identifier. |
| `provider` | Provider/system represented by adapter. |
| `runtimeClass` | Canonical runtime class. |
| `readCapabilities` | List of allowed read/report capabilities. |
| `planCapabilities` | List of plan-only capabilities. |
| `writeCapabilities` | Must remain blocked unless approved. |
| `approvalRequiredForWrite` | Must be true for any controlled write path. |
| `dryRunSupported` | Whether dry-run planning is supported. |
| `auditRequired` | Must be true for all adapters. |
| `forbiddenActionCategories` | Action categories that cannot be routed without separate approval. |
| `evidenceSources` | Canonical evidence files. |
| `fallbackOnUnknown` | Must be `NOT_CONFIGURED` or `PENDING_REVIEW`. |

## Adapter routing rules

1. The orchestrator must not route a request to an adapter unless the adapter declares the target capability.
2. Unknown adapter actions must resolve to `NOT_CONFIGURED` or `PENDING_REVIEW`.
3. Provider writes require explicit approval and cannot be inferred from adapter existence.
4. Dry-run support means plan-only simulation, not execution.
5. Adapter evidence must be traceable to canonical files.
6. An adapter may not override `config/provider-boundary.yml` or `config/action-classification.yml`.
7. The stricter classification wins when adapter evidence conflicts with canonical policy.

## Adapter status model

| Status | Meaning |
|---|---|
| `READ_ONLY_READY` | Adapter may provide read/report/introspection capability. |
| `PLAN_ONLY_READY` | Adapter may support plan-only/dry-run artifacts. |
| `CONTROLLED_WRITE_PENDING_APPROVAL` | Write capability exists or may exist, but execution is blocked. |
| `NOT_CONFIGURED` | Adapter is absent, incomplete, or unproven. |
| `PENDING_REVIEW` | Adapter evidence is stale, conflicting, or incomplete. |

## Initial adapter scope

O-RT6 covers adapter contracts for:

```text
github
wix
domeneshop
conta
powershell
python
custom_gpt
memory_ops
```

These are static control contracts. They do not create live provider clients.

## Acceptance criteria

| Criterion | Status |
|---|---|
| Adapter contract template complete | Complete |
| Static adapter registry complete | Complete |
| At least one read-only adapter validated | Complete by sample adapter |
| No adapter can bypass its own write gate | Enforced by tests |
| Unknown adapter actions are blocked | Enforced by config and tests |
| Evidence provenance required | Enforced by schema/config |

## Next release train

Proceed next with:

```text
O-RT7 — Approval-gated Operations Pilot
```

O-RT7 should pilot low-risk orchestrated operations only: read-only aggregation, evidence pack generation, and draft PR/change-pack generation. Provider, DNS, production, and destructive actions remain outside scope unless separately approved.
