# GitHub Actions Policy — Sanitized Export

## Repository

```text
nanotech-solutions-norway/NTSN-Orchestrator-Control-Plane
```

## Export status

```text
PARTIAL_EXPORT_GH_CLI_NOT_AVAILABLE
```

## Sanitized policy metadata

| Policy area | Value | Source |
|---|---|---|
| Actions enabled | `true` | Workflow runs exist and were executed |
| Allowed actions policy | `unknown` | GitHub CLI unavailable; UI/API export still needed |
| Default workflow token permission | `unknown` | GitHub CLI unavailable; UI/API export still needed |
| Observed workflow permission | `contents: read` | Orchestrator Drift Validation log review |
| Pull request workflow setting | `unknown` | GitHub CLI unavailable; UI/API export still needed |
| Fork workflow setting | `unknown` | GitHub CLI unavailable; UI/API export still needed |
| Artifact retention | `unknown` | GitHub CLI unavailable; UI/API export still needed |

## Local CLI attempt

```text
gh: The term 'gh' is not recognized as a name of a cmdlet, function, script file, or executable program.
```

## Resolution path

Use either GitHub UI:

```text
Repository -> Settings -> Actions -> General
```

or install/authenticate GitHub CLI locally before rerunning the API export.

## Notes

```text
Policy names and settings only. No protected values included.
```
