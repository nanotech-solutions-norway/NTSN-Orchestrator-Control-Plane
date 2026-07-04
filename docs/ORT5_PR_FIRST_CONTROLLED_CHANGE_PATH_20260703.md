# O-RT5 PR-first Controlled Change Path — 2026-07-03

## Release train

```text
O-RT5 — Controlled Change Path via GitHub PR
```

## Classification

```text
PLAN_ONLY_READY
CONTROLLED_WRITE_PENDING_APPROVAL
PR_FIRST_CHANGE_CONTROL
LIVE_WRITE_NOT_APPROVED
NO_DIRECT_PRODUCTION_WRITE
```

## Purpose

O-RT5 defines the first controlled change path for the NTSN Orchestrator Control Plane. The orchestrator may prepare sanitized change packs, draft PR instructions, review checklists, rollback notes, and validation requirements for GitHub-managed code/config changes.

O-RT5 does not approve direct provider writes, DNS writes, FTP/SFTP writes, SQL writes, accounting writes, production deployments, destructive operations, bulk sync/delete, direct provider publish actions, or automated merge/deploy.

## Change path

```text
Plan-only request
  -> O-RT3 plan artifact
  -> O-RT5 change pack
  -> branch/PR preparation instructions
  -> human review
  -> validation evidence
  -> merge/deploy decision outside this release train
```

## Required source files

```text
config/pr-change-control.yml
schemas/change-pack.schema.json
templates/change-pack/PR_FIRST_CHANGE_PACK_TEMPLATE.md
examples/change-packs/sample_pr_first_change_pack.json
.github/PULL_REQUEST_TEMPLATE/orchestrator-controlled-change.md
tests/Test-OrchestratorPrFirstChangePath.ps1
tests/Test-OrchestratorChangePackSchema.ps1
```

## Required change-pack sections

Each controlled change pack must include:

| Section | Requirement |
|---|---|
| `changeId` | Stable change identifier. |
| `mode` | Must be `PR_FIRST_CONTROLLED_CHANGE`. |
| `executionAllowed` | Must be `false` for provider/production actions. |
| `sourcePlan` | O-RT3 plan artifact or equivalent evidence. |
| `targetRepository` | GitHub repository affected. |
| `targetBranchStrategy` | Branch naming and PR-only target. |
| `filesToChange` | Intended changed files or placeholders. |
| `actionClass` | Canonical action classification. |
| `approvalRequired` | Human approval requirement. |
| `validationRequired` | Required validation suite/checks. |
| `rollbackPlan` | Revert/disable instructions. |
| `deploymentImpact` | None, development, staging, production, or provider. |
| `blockedActions` | Any blocked provider/write/deploy actions. |
| `auditOutputs` | Required record of decision, evidence, action, and validation outcome. |

## Allowed O-RT5 outputs

```text
SANITIZED_CHANGE_PACK
DRAFT_PR_INSTRUCTIONS
PATCH_REVIEW_NOTES
ROLLBACK_NOTES
VALIDATION_REQUIREMENTS
HUMAN_REVIEW_CHECKLIST
```

## Blocked O-RT5 actions

```text
DIRECT_MAIN_BRANCH_WRITE_FOR_FEATURE_CHANGE
AUTO_MERGE
AUTO_DEPLOY
DNS_WRITE
FTP_SFTP_WRITE
SQL_WRITE
ACCOUNTING_WRITE_OR_SUBMISSION
PRODUCTION_DEPLOYMENT
DESTRUCTIVE_OPERATION
DIRECT_PROVIDER_PUBLISH
SECRET_VALUE_EXPORT
```

## PR-first rule

Code/config changes that are not simple evidence-indexing updates must use the PR-first path. Direct commits to production-impacting files or provider state are not part of O-RT5.

## Approval rule

A PR/change pack may be prepared without approving execution. Approval must be explicit, recorded, and scoped. Approval for a GitHub PR does not imply approval for provider writes or production deployment.

## Validation rule

A change pack must list required validation before merge. For orchestrator control-plane changes, the minimum validation set is:

```powershell
./tests/Test-OrchestratorValidationSuite.ps1
./tests/Test-OrchestratorPrFirstChangePath.ps1
./tests/Test-OrchestratorChangePackSchema.ps1
```

## Audit rule

Every change pack must record:

1. decision;
2. evidence used;
3. action class;
4. target repository;
5. validation outcome;
6. rollback/disable path;
7. approval status.

## Acceptance criteria

| Criterion | Status |
|---|---|
| PR-first policy exists | Complete |
| Change-pack schema exists | Complete |
| Sample change pack exists | Complete |
| Human review required before merge/deploy | Complete |
| Direct provider/production writes remain blocked | Complete |
| Validation tests exist | Complete |

## Next release train

Proceed next with:

```text
O-RT6 — Provider Adapter Control Layer
```

O-RT6 should define adapter contracts for downstream providers. It must not allow adapters to exceed their declared capability or approval state.
