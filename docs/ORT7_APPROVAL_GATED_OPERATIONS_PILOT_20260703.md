# O-RT7 Approval-gated Operations Pilot — 2026-07-03

## Release train

```text
O-RT7 — Approval-gated Operations Pilot
```

## Classification

```text
APPROVAL_GATED_OPERATIONS_PILOT
READ_ONLY_READY
PLAN_ONLY_READY
PR_FIRST_CHANGE_CONTROL
CONTROLLED_WRITE_PENDING_APPROVAL
LIVE_WRITE_NOT_APPROVED
LOW_RISK_PILOT_ONLY
```

## Purpose

O-RT7 defines the first operations pilot for the NTSN Orchestrator Control Plane. The pilot is limited to low-risk orchestrated operations that do not mutate provider state and do not execute production changes.

Allowed pilot classes are:

1. read-only aggregation;
2. evidence-pack generation;
3. draft PR/change-pack generation.

Provider writes, DNS changes, FTP/SFTP writes, SQL writes, accounting writes, production deployments, destructive operations, bulk sync/delete, direct provider publish actions, secret-value export, and automatic merge/deploy remain outside O-RT7 scope unless separately approved in a later gated process.

## Required source files

```text
config/operations-pilot.yml
schemas/operations-pilot.schema.json
templates/operations-pilot/OPERATIONS_PILOT_RUNBOOK_TEMPLATE.md
examples/operations-pilot/sample_readonly_aggregation_pilot.json
examples/operations-pilot/sample_draft_change_pack_pilot.json
tests/Test-OrchestratorOperationsPilot.ps1
tests/Test-OrchestratorPilotNoProviderWrite.ps1
```

## Allowed pilot operations

| Pilot operation | Action class | Execution boundary |
|---|---|---|
| `read_only_aggregation` | `READ_ONLY_READY` | Reads canonical repository files only. |
| `evidence_pack_generation` | `PLAN_ONLY_READY` | Produces sanitized evidence pack references. |
| `draft_change_pack_generation` | `PR_FIRST_CHANGE_CONTROL` | Produces draft change-pack artifacts only. |

## Pilot approval gates

Every pilot run must declare:

| Gate | Requirement |
|---|---|
| `operatorApprovalRequired` | true |
| `executionAllowed` | false for provider/production actions |
| `globalWriteGates` | all false |
| `sourceEvidence` | canonical source file references |
| `targetAdapters` | adapter contract IDs only; no live client credentials |
| `blockedActions` | blocked action categories from policy |
| `validationRequired` | validation suite commands |
| `auditOutputs` | run record, evidence references, and approval state |

## Pilot run output

A pilot run may produce:

```text
READ_ONLY_SUMMARY
SANITIZED_EVIDENCE_PACK
DRAFT_CHANGE_PACK
VALIDATION_REPORT
OPERATOR_REVIEW_NOTES
```

It must not produce an executable provider payload.

## Completion criteria

| Criterion | Status |
|---|---|
| Pilot policy exists | Complete |
| Pilot schema exists | Complete |
| Read-only aggregation sample exists | Complete |
| Draft change-pack sample exists | Complete |
| No provider/production actions are allowed | Complete |
| Validation tests exist | Complete |

## Post-O-RT7 status

After O-RT7, the optimized build plan release train is complete through the approval-gated pilot definition. Further movement toward any write-capable provider operation requires a separate explicit approval package, dry-run evidence, rollback/disable plan, and provider-specific validation.
