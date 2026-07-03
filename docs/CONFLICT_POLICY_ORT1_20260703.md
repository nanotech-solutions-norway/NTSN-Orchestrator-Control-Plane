# Conflict Policy — O-RT1 — 2026-07-03

## Purpose

This policy defines how the orchestrator handles conflicts between evidence sources, connector observations, repository files, uploaded documents, Custom GPT configuration, MCP runtime evidence, and operator notes.

## Canonical rule

```text
LATEST APPROVED CANONICAL SOURCE WINS
CONFLICTS BECOME PENDING_REVIEW
NO SILENT MERGE
NO IMPLICIT WRITE APPROVAL
```

## Canonical source order

1. `config/approval-policy.yml`
2. `config/evidence-status.yml`
3. `config/orchestrator-registry.json`
4. `config/action-classification.yml`
5. `config/provider-boundary.yml`
6. `docs/ORCHESTRATOR_REGISTRY.md`
7. `docs/evidence/*.md`
8. `docs/validation/*.md`
9. external evidence packages
10. chat/operator notes

## Evidence staleness rule

Evidence must be treated as stale or incomplete when:

- it is marked `PENDING_REVIEW`;
- it comes from an old package and contradicts a current canonical file;
- it is connector-derived but not validated against the current target system;
- it describes expected structure rather than live export;
- it lacks source timestamp, scope, or authority boundary;
- it implies write capability without an approval record.

Stale evidence may inform a plan, but cannot approve execution.

## Unknown action rule

Any action, endpoint, tool, script, adapter, runtime, or provider capability absent from the registry must resolve to:

```text
NOT_CONFIGURED
```

or:

```text
PENDING_REVIEW
```

It must not be inferred as allowed.

## Write conflict rule

If any evidence source says a capability is write-capable, destructive, production-affecting, provider-mutating, DNS-mutating, SQL-mutating, accounting-mutating, or deployment-capable, the stricter classification wins:

```text
CONTROLLED_WRITE_PENDING_APPROVAL
```

unless a valid `LIVE_WRITE_APPROVED` canonical record exists. No such record exists in O-RT1.

## Provider-boundary rule

Provider adapters and downstream MCPs may not exceed their own declared capability and approval state. The orchestrator may coordinate, but not bypass downstream gates.

## Resolution procedure

For each conflict:

1. record conflict in the pending-review register;
2. identify source files and timestamps;
3. choose canonical owner;
4. update registry only after review;
5. preserve no-write boundary unless explicitly approved;
6. record validation outcome.

## Current enforcement status

```text
CONFLICT_POLICY_ACTIVE
STALE_EVIDENCE_NOT_APPROVED
UNKNOWN_ACTIONS_BLOCKED
LIVE_WRITE_NOT_APPROVED
```
