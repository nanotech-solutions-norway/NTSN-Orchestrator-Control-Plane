# Orchestrator Drift Validation Report

## Metadata

| Field | Value |
|---|---|
| Repository | `<repository>` |
| Release train | `O-RT4` |
| Validation timestamp UTC | `<validationTimestampUtc>` |
| Commit SHA/ref | `<commitShaOrRef>` |
| Validation mode | `VALIDATION_ONLY` |
| Execution allowed | `false` |

## Global write gates

```text
live_provider_write_approved: false
dns_write_approved: false
production_deployment_approved: false
destructive_operations_approved: false
```

## Checks run

| Check | Status | Severity on fail | Notes |
|---|---|---|---|
| Registry integrity | `<PASS/FAIL>` | HIGH | `<notes>` |
| Route/OpenAPI drift | `<PASS/FAIL>` | HIGH | `<notes>` |
| Provider boundary drift | `<PASS/FAIL>` | HIGH | `<notes>` |
| Plan-only enforcement | `<PASS/FAIL>` | HIGH | `<notes>` |
| Pending-review visibility | `<PASS/FAIL>` | MEDIUM | `<notes>` |
| Secret-pattern hygiene | `<PASS/FAIL>` | CRITICAL | `<notes>` |

## Findings by severity

### CRITICAL

```text
<criticalFindingsOrNone>
```

### HIGH

```text
<highFindingsOrNone>
```

### MEDIUM

```text
<mediumFindingsOrNone>
```

### LOW

```text
<lowFindingsOrNone>
```

### INFO

```text
<infoFindingsOrNone>
```

## Pass/fail status

```text
<VALIDATION_PASSED_OR_FAILED>
```

## Next actions

```text
<nextActions>
```

## Boundary confirmation

```text
NO_PROVIDER_MUTATION
NO_WORKFLOW_WRITE_DISPATCH
NO_DNS_WRITE
NO_FTP_SFTP_WRITE
NO_SQL_WRITE
NO_ACCOUNTING_WRITE
NO_PRODUCTION_DEPLOYMENT
NO_DESTRUCTIVE_OPERATION
NO_DIRECT_PROVIDER_PUBLISH
NO_SECRET_VALUE_READOUT
```
