# Domeneshop Provider Evidence Intake — 12:05, 02.07.2026

## Source package

Uploaded evidence package:

```text
domeneshop_provider_evidence_1205_02072026.zip
```

Package SHA-256:

```text
4564670dc25545fe6eaea532ad0003ab692b5bfe98690d6223c0d4619aaaad90
```

## Sanitization status

The package states that secrets, passwords, API keys, bearer tokens, private customer data, database row data, raw logs, backups, private payloads, and full `.env` / local runtime values are excluded. A local pattern scan found no obvious credential values.

## Files included in source package

| File | Size bytes | SHA-256 |
|---|---:|---|
| `DOMENESHOP_SERVER_INVENTORY.md` | 10607 | `6b5742176b9f1311f3ac634530ee32b822cf75eaf802a83998c4140a00ec8f4b` |
| `DOMENESHOP_SERVER_FILE_TREE_SANITIZED.txt` | 5841 | `d986c370947491e7dce9fef312f2d7117452ed46b3dd93594ae05219e418dc6c` |
| `DOMENESHOP_SQL_SCHEMA_SANITIZED.md` | 5565 | `052d4c5ec9c94bfa2f112edaaf238bad7878bdde5403b0275107f48f3a89b707` |
| `DOMENESHOP_RUNTIME_ENDPOINTS.md` | 6537 | `fbbdd2cb664546203df81cfa85c91621be1859e66d77d70e8b41ff6f0b8f9f91` |
| `DOMENESHOP_ACCESS_BOUNDARY.md` | 7666 | `ad1c9858f25bbc6f099e0137f4c99a38c855697660e6294b57746175fedcda6b` |

## Evidence sections detected

The package contains these evidence categories:

1. Domeneshop server inventory.
2. Sanitized server file tree.
3. Sanitized SQL schema summary.
4. Runtime endpoint inventory.
5. Access-boundary classification.

## Important caveats from source package

The source files are marked `PENDING_REVIEW`. Several sections state that the material is based on documented project evidence and expected deployment structures, not a fresh live FTP/SFTP listing, live endpoint crawl, or full phpMyAdmin schema export.

## Relevant domains/subdomains and systems detected

Detected Domeneshop-hosted or Domeneshop-related systems include:

- `forms.nanotech-solutions.com`
- `pip.atlas-ai.no`
- `monitor.atlas-ai.no`
- Atlas PIP/API/control paths
- SolarEX forms/admin backend
- Domeneshop MCP runtime paths
- Conta MCP runtime paths
- SolarEX/NTSN forms SQL backend
- Atlas/PIP SQL backend

## SQL evidence status

The SQL evidence identifies documented database/logical aliases and table names for SolarEX forms/admin. Full columns, types, primary keys, indexes, constraints, triggers, views, routines, and live metadata still require a manual phpMyAdmin/SQL metadata export.

## Runtime endpoint status

The runtime endpoint file is an endpoint inventory and expected-status register, not a fresh live endpoint crawl. Operator-controlled endpoint validation remains required before promoting the evidence from indexed to validated.

## Access-boundary classification

The access-boundary evidence distinguishes:

- items manageable through Domeneshop API when credentials are configured;
- items requiring FTP/SFTP;
- items requiring SQL/phpMyAdmin;
- items requiring manual control-panel action;
- items that must remain outside ChatGPT/GitHub.

## Orchestrator classification

```text
DOMENESHOP_PROVIDER_EVIDENCE_RECEIVED
DOMENESHOP_PROVIDER_EVIDENCE_INDEXED
RAW_CREDENTIAL_VALUES_NOT_DETECTED_BY_PATTERN_SCAN
PENDING_REVIEW_IN_SOURCE_PACKAGE
LIVE_FTP_TREE_NOT_CONFIRMED
FULL_SQL_SCHEMA_NOT_EXPORTED
LIVE_ENDPOINT_CRAWL_NOT_CONFIRMED
LIVE_WRITE_NOT_APPROVED
```

## Next required action

Use the access-boundary evidence to refine `config/provider-boundary.yml`. Use the runtime-endpoint evidence to define read-only endpoint checks. Do not enable Domeneshop DNS writes, FTP/SFTP writes, SQL writes, or provider mutations from this evidence alone.
