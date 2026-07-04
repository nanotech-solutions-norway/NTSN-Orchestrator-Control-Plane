# O-RT3 Plan-only Orchestration Engine — 2026-07-03

## Release train

```text
O-RT3 — Plan-only Orchestration Engine
```

## Classification

```text
PLAN_ONLY_READY
READ_ONLY_READY
CONTROLLED_WRITE_PENDING_APPROVAL
LIVE_WRITE_NOT_APPROVED
NO_EXECUTION_ENGINE
```

## Purpose

O-RT3 defines a plan-only orchestration engine for the NTSN Orchestrator Control Plane. The engine may compile multi-provider operation plans for operator review, but it must not execute provider writes, workflow dispatches, DNS changes, FTP/SFTP writes, SQL changes, accounting mutations, production deployments, destructive operations, bulk sync/delete, or direct provider publish actions.

## Scope

The plan-only engine may produce structured plans that include:

1. requested objective;
2. target systems and downstream MCPs;
3. pre-checks;
4. required evidence;
5. action class per step;
6. required approval per step;
7. payload shape with placeholders only;
8. rollback or disable plan;
9. validation steps;
10. audit/evidence output requirements.

## Non-execution rule

```text
PLAN_COMPILATION_ONLY
NO_TOOL_DISPATCH
NO_PROVIDER_MUTATION
NO_WORKFLOW_WRITE_DISPATCH
NO_SECRET_USE
NO_PRIVATE_PAYLOAD_EXPORT
```

The plan compiler must not call downstream write routes. It may describe target MCPs, commands, payload fields, or workflow names for review, but it must not execute them.

## Source files

```text
config/plan-only-policy.yml
schemas/orchestrator-plan.schema.json
examples/plan-only/sample_provider_change_plan.json
tests/Test-PlanOnlyPolicyEngine.ps1
tests/Test-OrchestratorPlanSchema.ps1
```

## Required plan structure

Each plan must include:

| Field | Requirement |
|---|---|
| `planId` | Stable plan identifier. |
| `mode` | Must be `PLAN_ONLY`. |
| `executionAllowed` | Must be `false`. |
| `requestedObjective` | Human-readable objective. |
| `sourceEvidence` | Evidence file references used to compile the plan. |
| `globalWriteGates` | All write gates must remain false. |
| `steps` | Ordered step list. |
| `steps[].actionClass` | One of canonical action classes. |
| `steps[].approvalRequired` | Required for all non-read-only actions. |
| `steps[].payloadShape` | Placeholder-only payload description. |
| `steps[].blockedReason` | Required when step is not executable. |
| `rollbackPlan` | Required rollback/disable plan. |
| `validationPlan` | Required validation steps. |
| `auditOutputs` | Required evidence/log outputs. |

## Policy decisions

| Input condition | Plan engine behavior |
|---|---|
| Read-only evidence request | Compile `READ_ONLY_READY` plan step. |
| Plan-only operation | Compile `PLAN_ONLY_READY` plan step. |
| Any provider write or mutation | Compile blocked `CONTROLLED_WRITE_PENDING_APPROVAL` step. |
| Unknown capability | Compile blocked `NOT_CONFIGURED` step. |
| Stale/conflicting evidence | Compile blocked `PENDING_REVIEW` step. |
| Secret-bearing payload | Reject or replace with placeholder. |
| Missing rollback plan for write-class step | Block plan readiness. |
| Missing evidence for target MCP/provider | Block step as `PENDING_REVIEW` or `NOT_CONFIGURED`. |

## Allowed plan actions

```text
READ_ONLY_STEP
PLAN_ONLY_STEP
EVIDENCE_COLLECTION_STEP
VALIDATION_STEP
OPERATOR_REVIEW_STEP
DRAFT_CHANGE_PACK_STEP
```

## Blocked execution actions

```text
DNS_WRITE_EXECUTION
FTP_SFTP_WRITE_EXECUTION
SQL_WRITE_EXECUTION
ACCOUNTING_WRITE_EXECUTION
WORKFLOW_WRITE_DISPATCH
PRODUCTION_DEPLOYMENT_EXECUTION
DESTRUCTIVE_OPERATION_EXECUTION
DIRECT_PROVIDER_PUBLISH_EXECUTION
```

## Acceptance criteria

| Criterion | Status |
|---|---|
| Plan output contains no secrets | Enforced by schema and policy. |
| Plan engine refuses unapproved writes | Enforced by policy. |
| Plan evidence is sufficient for operator review | Enforced by required evidence fields. |
| Unknown/stale/conflicting actions are blocked | Enforced by canonical classes. |
| Rollback/validation/audit sections are required | Enforced by schema. |

## Next release train

Proceed next with:

```text
O-RT4 — Validation and Drift Detection Harness
```

O-RT4 should automate registry integrity, OpenAPI/action-schema drift, route availability, auth behavior, and no-write exposure checks without making write calls.
