# GitHub Admin and Environment Protection Export — 2026-07-06

## Repository

```text
nanotech-solutions-norway/NTSN-Orchestrator-Control-Plane
```

## Export classification

```text
GITHUB_ADMIN_ENVIRONMENT_PROTECTION_EXPORT
CONNECTOR_VERIFIED_REPOSITORY_METADATA
OPERATOR_ADMIN_UI_NEGATIVE_FINDINGS_RECORDED
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

## Uploaded admin export files

Folder:

```text
docs/evidence/github-admin-export/
```

| File | Current status |
|---|---|
| `GITHUB_REPOSITORY_ADMIN_SETTINGS_SANITIZED.md` | `PARTIAL_CONNECTOR_VERIFIED_EXPORT` |
| `GITHUB_ENVIRONMENTS_PROTECTION_EXPORT_SANITIZED.json` | `COMPLETE_NO_ENVIRONMENTS_CONFIGURED` |
| `GITHUB_BRANCH_PROTECTION_EXPORT_SANITIZED.json` | `COMPLETE_NO_BRANCH_PROTECTION_RULES_CONFIGURED` |
| `GITHUB_RULESETS_EXPORT_SANITIZED.json` | `COMPLETE_NO_RULESETS_CONFIGURED` |
| `GITHUB_ACTIONS_POLICY_EXPORT_SANITIZED.md` | `PARTIAL_EXPORT_GH_CLI_NOT_AVAILABLE` |
| `GITHUB_SECRETS_VARIABLES_NAMES_ONLY.md` | `UPLOAD_REVIEWED_NO_NAMES_PROVIDED` |
| `GITHUB_ADMIN_EXPORT_UPLOAD_REVIEW_20260706.md` | `UPLOAD_REVIEW_COMPLETE` |

## Current admin evidence status

| Evidence item | Status |
|---|---|
| GitHub Environments list | `NONE_CONFIGURED_OPERATOR_CONFIRMED` |
| Per-environment protection rules | `NOT_APPLICABLE_NO_ENVIRONMENTS` |
| Required reviewers for environments | `NOT_APPLICABLE_NO_ENVIRONMENTS` |
| Environment deployment branch policies | `NOT_APPLICABLE_NO_ENVIRONMENTS` |
| Branch protection for `main` | `NONE_CONFIGURED_OPERATOR_CONFIRMED` |
| Repository rulesets | `NONE_CONFIGURED_OPERATOR_CONFIRMED` |
| Actions allowed actions policy | `UNKNOWN_GH_CLI_NOT_AVAILABLE` |
| Default repository workflow token permission | `UNKNOWN_GH_CLI_NOT_AVAILABLE` |
| Secrets inventory, names only | `NO_NAMES_PROVIDED` |
| Variables inventory, names only | `NO_NAMES_PROVIDED` |

## GitHub Actions workflow protection evidence currently available in repo

| File | Evidence |
|---|---|
| `.github/workflows/orchestrator-drift-validation.yml` | Workflow exists and uses read-only repository permission. |
| `docs/validation/ORCHESTRATOR_DRIFT_VALIDATION_LOG_REVIEW_77722940956_20260706.md` | Recent workflow log review. |
| `docs/validation/ORCHESTRATOR_DRIFT_VALIDATION_LOG_REVIEW_77656234734_20260705.md` | Previous workflow log review. |

## GitHub CLI status

The local PowerShell attempt showed that `gh` is not installed or not available on PATH:

```text
gh: The term 'gh' is not recognized as a name of a cmdlet, function, script file, or executable program.
```

The remaining Actions policy fields require either GitHub UI review or GitHub CLI/API access from an admin-authenticated environment.

## Required redaction rule

```text
Do not include secret values, token values, private payloads, customer data, full protected headers, or raw credential material.
```

## Current control decision

The available evidence supports repository metadata intake and negative admin configuration findings for environments, branch protection, and rulesets. The export is still partial because Actions policy settings and names-only secret/variable inventories are incomplete.

```text
GITHUB_ADMIN_EXPORT_NEGATIVE_FINDINGS_RECORDED
GITHUB_ACTIONS_POLICY_PARTIAL_GH_CLI_NOT_AVAILABLE
GITHUB_SECRETS_VARIABLES_NAMES_ONLY_PENDING
NO_LIVE_WRITE_APPROVAL
```
