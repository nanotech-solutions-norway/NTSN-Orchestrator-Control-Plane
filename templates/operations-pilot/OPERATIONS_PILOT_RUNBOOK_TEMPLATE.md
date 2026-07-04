# Approval-gated Operations Pilot Runbook

## Metadata

| Field | Value |
|---|---|
| Pilot ID | `<pilotId>` |
| Release train | `O-RT7` |
| Mode | `APPROVAL_GATED_OPERATIONS_PILOT` |
| Pilot operation | `<read_only_aggregation/evidence_pack_generation/draft_change_pack_generation>` |
| Operator approval required | `true` |
| Execution allowed | `false` |

## Source evidence

```text
<canonical source files>
```

## Target adapters

```text
<adapter contract IDs only>
```

## Global write gates

```text
liveProviderWriteApproved: false
dnsWriteApproved: false
productionDeploymentApproved: false
destructiveOperationsApproved: false
```

## Planned output

```text
<READ_ONLY_SUMMARY / SANITIZED_EVIDENCE_PACK / DRAFT_CHANGE_PACK / VALIDATION_REPORT / OPERATOR_REVIEW_NOTES>
```

## Validation required

```powershell
./tests/Test-OrchestratorValidationSuite.ps1
./tests/Test-OrchestratorOperationsPilot.ps1
./tests/Test-OrchestratorPilotNoProviderWrite.ps1
```

## Audit outputs

```text
Pilot run ID
Operator approval status
Source evidence
Target adapters
Validation outcome
Generated artifacts
Blocked-action confirmation
```

## Boundary confirmation

```text
LOW_RISK_PILOT_ONLY
NO_PROVIDER_STATE_CHANGE
NO_PRODUCTION_CHANGE
NO_SECRET_VALUE_EXPORT
```
