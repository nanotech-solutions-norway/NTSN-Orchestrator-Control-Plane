# GitHub Admin and Environment Protection Export — 2026-07-06

## Repository

```text
nanotech-solutions-norway/NTSN-Orchestrator-Control-Plane
```

## Export classification

```text
GITHUB_ADMIN_ENVIRONMENT_PROTECTION_EXPORT
CONNECTOR_VERIFIED_REPOSITORY_METADATA
ADMIN_ENVIRONMENT_PROTECTION_EVIDENCE_PARTIAL
NO_SECRET_VALUES_INCLUDED
LIVE_WRITE_NOT_APPROVED
```

## Connector-verified repository metadata

| Field | Value |
|---|---|
| Repository ID | `1283445916` |
| Repository name | `NTSN-Orchestrator-Control-Plane` |
| Owner | `nanotech-solutions-norway` |
| Owner type | `User` |
| Visibility | `public` |
| Archived | `false` |
| Default branch | `main` |
| Clone URL | `https://github.com/nanotech-solutions-norway/NTSN-Orchestrator-Control-Plane.git` |
| Repository size | `146` |

## Connector-verified permissions for current connector context

| Permission | Value |
|---|---|
| admin | `true` |
| maintain | `true` |
| push | `true` |
| pull | `true` |
| triage | `true` |

## Connector-verified merge settings

| Setting | Value |
|---|---|
| allow_auto_merge | `false` |
| allow_merge_commit | `true` |
| allow_rebase_merge | `true` |
| allow_squash_merge | `true` |
| allow_update_branch | `false` |

## GitHub Actions workflow protection evidence currently available in repo

| File | Evidence |
|---|---|
| `.github/workflows/orchestrator-drift-validation.yml` | Workflow exists and uses read-only repository permission. |
| `docs/validation/ORCHESTRATOR_DRIFT_VALIDATION_LOG_REVIEW_77722940956_20260706.md` | Recent workflow log review. |
| `docs/validation/ORCHESTRATOR_DRIFT_VALIDATION_LOG_REVIEW_77656234734_20260705.md` | Previous workflow log review. |

## Environment protection evidence status

The current connector output verifies repository-level metadata and connector-context permissions. It does not expose a complete export of GitHub repository environments, branch protection rules, required reviewers, deployment branch policies, environment secrets, variables, or rulesets.

Therefore, these fields remain pending admin export:

| Evidence item | Status |
|---|---|
| GitHub Environments list | `PENDING_ADMIN_EXPORT` |
| Per-environment protection rules | `PENDING_ADMIN_EXPORT` |
| Required reviewers for environments | `PENDING_ADMIN_EXPORT` |
| Environment deployment branch policies | `PENDING_ADMIN_EXPORT` |
| Branch protection for `main` | `PENDING_ADMIN_EXPORT` |
| Repository rulesets | `PENDING_ADMIN_EXPORT` |
| Actions workflow permissions settings | `PENDING_ADMIN_EXPORT` |
| Actions allowed actions policy | `PENDING_ADMIN_EXPORT` |
| Secrets inventory, names only | `PENDING_ADMIN_EXPORT` |
| Variables inventory, names only | `PENDING_ADMIN_EXPORT` |

## Required admin export method

Use GitHub UI or GitHub CLI/API from an admin-authenticated local environment. Export names and policy metadata only. Do not export secret values.

Recommended evidence outputs:

```text
GITHUB_REPOSITORY_ADMIN_SETTINGS_SANITIZED.md
GITHUB_ENVIRONMENTS_PROTECTION_EXPORT_SANITIZED.json
GITHUB_BRANCH_PROTECTION_EXPORT_SANITIZED.json
GITHUB_RULESETS_EXPORT_SANITIZED.json
GITHUB_ACTIONS_POLICY_EXPORT_SANITIZED.md
GITHUB_SECRETS_VARIABLES_NAMES_ONLY.md
```

## Required redaction rule

```text
Do not include secret values, token values, private payloads, customer data, full protected headers, or raw credential material.
```

## Current control decision

The available connector evidence supports repository metadata intake and confirms auto-merge is disabled. It is not sufficient to mark GitHub admin/environment protection as fully validated.

```text
GITHUB_ADMIN_ENVIRONMENT_PROTECTION_PARTIAL_EXPORT_COMPLETE
GITHUB_ADMIN_ENVIRONMENT_PROTECTION_FULL_EXPORT_PENDING
NO_LIVE_WRITE_APPROVAL
```
