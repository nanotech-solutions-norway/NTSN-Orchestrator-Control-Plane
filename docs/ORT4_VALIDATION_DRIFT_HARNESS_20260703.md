# O-RT4 Validation and Drift Detection Harness — 2026-07-03

## Release train

```text
O-RT4 — Validation and Drift Detection Harness
```

## Classification

```text
READ_ONLY_READY
PLAN_ONLY_READY
CONTROLLED_WRITE_PENDING_APPROVAL
LIVE_WRITE_NOT_APPROVED
NO_WRITE_VALIDATION_ONLY
```

## Purpose

O-RT4 defines deterministic validation and drift detection for the NTSN Orchestrator Control Plane. It verifies registry integrity, OpenAPI/route-map drift, provider-boundary consistency, plan-only enforcement, pending-review visibility, and no-write exposure.

This harness must not execute writes, provider calls, workflow write dispatches, DNS mutations, FTP/SFTP changes, SQL changes, accounting mutations, production deployments, destructive operations, bulk sync/delete, or direct provider publish actions.

## Source files

```text
config/drift-detection.yml
reports/templates/ORCHESTRATOR_DRIFT_VALIDATION_REPORT_TEMPLATE.md
.github/workflows/orchestrator-drift-validation.yml
tests/Test-OrchestratorDriftHarness.ps1
tests/Test-OrchestratorRouteOpenApiDrift.ps1
tests/Test-OrchestratorProviderBoundaryDrift.ps1
tests/Test-OrchestratorValidationSuite.ps1
```

## Validation domains

| Domain | Purpose | Output |
|---|---|---|
| Registry integrity | Verify canonical files and no-live-write markers. | PASS/FAIL and severity. |
| Route/OpenAPI drift | Verify route map and OpenAPI paths remain aligned and GET-only. | PASS/FAIL and drift list. |
| Provider boundary drift | Verify providers have write status, caveats, and blocked actions. | PASS/FAIL and provider findings. |
| Plan-only enforcement | Verify O-RT3 plans cannot execute and write gates remain false. | PASS/FAIL and policy findings. |
| Pending-review visibility | Verify pending review items remain visible and are not promoted silently. | PASS/FAIL and review register findings. |
| Secret-pattern hygiene | Scan validation-controlled files for obvious credential-value patterns. | PASS/FAIL and redacted finding only. |

## Severity model

| Severity | Meaning | Default outcome |
|---|---|---|
| `INFO` | Informational drift or missing optional note. | Report only. |
| `LOW` | Non-blocking metadata inconsistency. | Report and review. |
| `MEDIUM` | Evidence mismatch or missing source reference. | Mark pending review. |
| `HIGH` | Route/schema/provider boundary conflict. | Fail validation. |
| `CRITICAL` | Any write exposure, live-write approval without canonical evidence, or secret-value exposure. | Fail validation and block readiness. |

## Deterministic report requirement

Validation output must be deterministic for the same repository state. Report fields must include:

```text
repository
releaseTrain
validationTimestampUtc
commitShaOrRef
checksRun
findingsBySeverity
globalWriteGates
passFailStatus
nextActions
```

## No-write validation rule

Validation tests may read repository files and inspect static schemas only. They must not call downstream provider endpoints, perform workflow dispatch, mutate repository files, access secret values, or trigger deployment.

## Acceptance criteria

| Criterion | Status |
|---|---|
| Validation report can be produced deterministically | Complete by report template and validation suite. |
| Drift is classified by severity | Complete by `config/drift-detection.yml`. |
| No write calls are made during validation | Enforced by policy and tests. |
| Route/OpenAPI drift is detectable | Complete by route/OpenAPI test. |
| Provider boundary drift is detectable | Complete by provider-boundary test. |
| No-write exposure is checked | Complete by validation suite. |

## Next release train

Proceed next with:

```text
O-RT5 — Controlled Change Path via GitHub PR
```

O-RT5 should prepare PR-first controlled change packs, not direct production/provider writes.
