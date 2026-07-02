# Python Environment Control Plane Inclusion — 2026-07-02

## Decision

The Python environment is included in the NTSN Orchestrator Control Plane as a managed execution, testing, debugging, validation, artifact-inspection, and repository-intelligence layer.

## Repository

```text
nanotech-solutions-norway/Phyton
```

## Orchestrator role

The orchestrator may route read-only/reporting Python tasks to the Python environment through documented GitHub Actions workflows. The Python repository remains separate and is not merged into the orchestrator repository.

## Current operating boundary

```text
DEVELOPMENT_ONLY
READ_ONLY
REPOSITORY_LOCAL
NO_STAGING_WRITES
NO_PRODUCTION_WRITES
NO_EXTERNAL_SYSTEM_WRITES
NO_SECRET_CONSUMING_SCRIPTS
NO_ARBITRARY_SHELL_COMMANDS
```

## Registered workflows

| Workflow | Orchestrator class | Approval |
|---|---|---|
| `CI - Python Quality Gate` | READ_ONLY | auto_approved |
| `CI - Python Full Validation` | REPORT_ONLY | auto_approved |
| `Manual - Python Debug` | REPORT_ONLY | auto_approved, development only |
| `Manual - Python Run Script` | READ_ONLY | auto_approved, development/read_only only |
| `Manual - Python Inspect Artifacts` | REPORT_ONLY | auto_approved, development only |
| `Manual - Python Validate Registry` | REPORT_ONLY | auto_approved, development only |

## Registered script keys

| Script key | Purpose |
|---|---|
| `hello_control_plane` | Foundation validation script |
| `repository_inventory` | Repository file inventory report |
| `workflow_inventory` | GitHub Actions workflow inventory report |
| `dependency_inventory` | Python dependency file inventory report |
| `repository_health_report` | Consolidated repository health report |
| `control_plane_readiness` | Control-plane readiness report |

## Evidence source

Primary evidence source:

```text
nanotech-solutions-norway/Phyton/docs/PHASE7_OPERATIONS_HANDOFF.md
```

Secondary evidence sources:

```text
nanotech-solutions-norway/Phyton/README.md
nanotech-solutions-norway/Phyton/docs/CHATGPT_PYTHON_ORCHESTRATOR_COMMANDS.md
```

## Required validation route

Default validation:

```text
CI - Python Full Validation
```

Manual fallback validation:

1. `CI - Python Quality Gate`
2. `CI - Python Full Validation`
3. `Manual - Python Run Script` with `repository_health_report`, `target_environment=development`, `run_mode=read_only`
4. `Manual - Python Run Script` with `control_plane_readiness`, `target_environment=development`, `run_mode=read_only`
5. `Manual - Python Validate Registry` with `target_environment=development`

## Current orchestrator classification

```text
PYTHON_ENVIRONMENT_INCLUDED
READ_ONLY_READY_PENDING_NEXT_VALIDATION_RUN
LIVE_WRITE_NOT_APPROVED
```
