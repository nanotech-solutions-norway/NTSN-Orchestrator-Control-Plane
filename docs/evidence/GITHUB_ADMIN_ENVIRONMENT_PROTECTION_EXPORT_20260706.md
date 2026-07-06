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
ACTIONS_POLICY_OPERATOR_UI_REVIEW_COMPLETE
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
| `GITHUB_ACTIONS_POLICY_EXPORT_SANITIZED.md` | `COMPLETE_OPERATOR_UI_REVIEW` |
| `GITHUB_SECRETS_VARIABLES_NAMES_ONLY.md` | `PARTIAL_OPERATOR_UI_REVIEW_SECRETS_ONLY` |
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
| Actions allowed actions policy | `ALLOW_ALL_ACTIONS_AND_REUSABLE_WORKFLOWS_OPERATOR_CONFIRMED` |
| Require actions pinned to full-length commit SHA | `FALSE_OPERATOR_CONFIRMED` |
| Artifact and log retention | `90_DAYS_OPERATOR_CONFIRMED` |
| Fork pull request workflow approval | `REQUIRE_APPROVAL_FOR_FIRST_TIME_CONTRIBUTORS_OPERATOR_CONFIRMED` |
| Default repository workflow token permission | `READ_REPOSITORY_CONTENTS_AND_PACKAGES_OPERATOR_CONFIRMED` |
| Allow GitHub Actions to create and approve pull requests | `FALSE_OPERATOR_CONFIRMED` |
| Repository secrets inventory, names only | `NONE_CONFIGURED_OPERATOR_CONFIRMED` |
| Environment secrets inventory, names only | `NONE_CONFIGURED_OPERATOR_CONFIRMED` |
| Repository variables inventory, names only | `PENDING_VARIABLES_TAB_CONFIRMATION` |
| Environment variables inventory, names only | `PENDING_VARIABLES_TAB_CONFIRMATION` |

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

GitHub UI evidence has now completed the Actions policy section.

## Required redaction rule

```text
Do not include secret values, token values, private payloads, customer data, full protected headers, or raw credential material.
```

## Current control decision

The available evidence supports repository metadata intake, negative admin configuration findings for environments, branch protection, and rulesets, and completed Actions policy review. The export remains partial only because the Variables tab has not been evidenced.

```text
GITHUB_ADMIN_EXPORT_NEGATIVE_FINDINGS_RECORDED
GITHUB_ACTIONS_POLICY_OPERATOR_UI_REVIEW_COMPLETE
GITHUB_REPOSITORY_SECRETS_NONE_OPERATOR_CONFIRMED
GITHUB_VARIABLES_NAMES_ONLY_PENDING
NO_LIVE_WRITE_APPROVAL
```
