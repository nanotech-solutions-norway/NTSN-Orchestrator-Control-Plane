# PR-first Controlled Change Pack

## Metadata

| Field | Value |
|---|---|
| Change ID | `<changeId>` |
| Release train | `O-RT5` |
| Mode | `PR_FIRST_CONTROLLED_CHANGE` |
| Execution allowed | `false` |
| Target repository | `<owner/repo>` |
| Base branch | `main` |
| Proposed branch | `<branch-name>` |

## Source plan

```text
<sourcePlanId>
<sourcePlanFile>
```

## Change objective

```text
<objective>
```

## Files to change

| Path | Change type | Impact | Notes |
|---|---|---|---|
| `<path>` | `<create/update/remove/rename/review_only>` | `<none/development/staging/production/provider>` | `<notes>` |

## Action class

```text
<PLAN_ONLY_READY / CONTROLLED_WRITE_PENDING_APPROVAL / PENDING_REVIEW / NOT_CONFIGURED>
```

## Approval requirement

```text
Human review required: true
Explicit approval required: true
Approval scope required: true
Deployment approval separate from merge approval: true
```

## Required validation

```powershell
./tests/Test-OrchestratorValidationSuite.ps1
./tests/Test-OrchestratorPrFirstChangePath.ps1
./tests/Test-OrchestratorChangePackSchema.ps1
```

## Rollback / disable plan

```text
<rollback or disable instructions>
```

## Blocked actions

```text
Direct main-branch feature change
Automatic merge
Automatic deployment
Provider/DNS/FTP/SFTP/SQL/accounting/production/destructive/direct-publish actions
Credential or private payload export
```

## Audit outputs

```text
Decision
Evidence used
Action class
Target repository
Validation outcome
Rollback or disable path
Approval status
```

## Current status

```text
CHANGE_PACK_PREPARED
EXECUTION_NOT_APPROVED
PROVIDER_WRITE_NOT_APPROVED
PRODUCTION_DEPLOYMENT_NOT_APPROVED
```
