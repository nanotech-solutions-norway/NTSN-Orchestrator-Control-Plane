# GitHub Repository Names-only Inventory — Sanitized Export

## Repository

```text
nanotech-solutions-norway/NTSN-Orchestrator-Control-Plane
```

## Export status

```text
PARTIAL_OPERATOR_UI_REVIEW_SECRETS_ONLY
```

## Operator UI evidence reviewed

```text
Repository -> Settings -> Secrets and variables -> Actions -> Secrets tab
```

## Repository-level entries

| Type | Name | Scope | Notes |
|---|---|---|---|
| secret | `none_configured` | repository | GitHub UI shows: This repository has no secrets. |
| variable | `not_evidenced_variables_tab_not_shown` | repository | Variables tab was not included in the screenshot. |

## Environment-level entries

| Environment | Type | Name | Notes |
|---|---|---|---|
| `not_applicable_no_environments_configured` | secret | `none_configured` | GitHub UI shows no environment secrets; no environments are configured in the admin export. |
| `not_evidenced_variables_tab_not_shown` | variable | `not_evidenced_variables_tab_not_shown` | Variables tab was not included in the screenshot. |

## Remaining evidence needed

```text
Variables tab confirmation: no repository variables / list names only if variables exist.
```

## Rule

```text
Names only. Do not paste values.
```
