# MCP Runtime and Client Configuration Evidence Intake — 12:33, 04.07.2026

## Source package

Uploaded evidence package:

```text
NTSN_MCP_Runtime_Client_Config_Evidence_1233_04072026.zip
```

Package SHA-256:

```text
0cbd49dc6c4a3b5c6ad6e47b4540ae991bea0f59b63dfc263579097c2c711607
```

## Sanitization status

The package states that secrets, bearer tokens, API keys, passwords, private headers, and full `.env` values are omitted. A local pattern scan found no obvious credential values.

## Files included in source package

| File | Size bytes | SHA-256 |
|---|---:|---|
| `MCP_RUNTIME_INVENTORY.md` | 9957 | `4b3e8f3310f7e2fd4e9e509f8e1191cf2c7ea7d259f2bf1564e389c557f9f296` |
| `MCP_CLIENT_CONFIG_SANITIZED.json` | 8068 | `8d4330a26d845b7e358cbc17b119beaa22c270c73617072f31f199e539605f91` |
| `MCP_TOOL_REGISTRY.md` | 13118 | `5dcfa773741899dfae616dd440ce03d72aeaa7db701ef6139b46bf03ef672fcb` |
| `MCP_RUNTIME_HEALTH_REPORT.md` | 6821 | `dbee1146b7c3c1c0e785b90bbfa0edb033e070d87d9bd69be3f2a3c335430050` |
| `MCP_WRITE_CAPABILITY_AUDIT.md` | 8277 | `2de3c3325d86434978b2def62898ce842f376e54eaa0c71a9903825bc8551fbf` |

## Evidence sections detected

The package contains these evidence categories:

1. MCP runtime inventory.
2. Sanitized MCP client configuration.
3. MCP tool registry.
4. MCP runtime health report.
5. MCP write-capability audit.

## Important limitations from source package

The health report states that no live external HTTP probe was completed as part of this evidence package. Runtime health entries distinguish evidence status from fresh live HTTP status.

The package also states that no live bearer-token endpoint call was performed, no live write tests were run, and no Claude Desktop, Cursor, local MCP JSON file, or server-side `.env` file was available as reviewed raw evidence.

## Client entries detected

The sanitized client config contains 11 client/server entries:

```text
conta-mcp
domeneshop-mcp-public-health
domeneshop-mcp-status
ntsn-orchestrator-control-plane
powershell-control-plane
python-control-plane
github-connector
wix-connector
ai-memory-ops
claude-desktop-local-mcp
cursor-local-mcp
```

## Readiness classes detected

Detected readiness classes include:

```text
READ_ONLY_READY
PLAN_ONLY_READY
CONTROLLED_WRITE_PENDING_APPROVAL
NOT_CONFIGURED
```

No item is classified as `LIVE_WRITE_APPROVED`.

## Key runtime alignment findings

- NTSN Orchestrator repository baseline remains `READ_ONLY_READY`; no public runtime base URL is evidenced.
- Domeneshop MCP public health is `READ_ONLY_READY`; HTTPS readiness remains pending certificate correction.
- Domeneshop protected status is `PLAN_ONLY_READY` and operator-local only.
- Conta MCP v0.1 is `PLAN_ONLY_READY` until sandbox/server validation evidence is refreshed.
- PowerShell control plane has controlled development-maintenance capability but remains policy-gated.
- Python control plane remains `READ_ONLY_READY` for approved registered scripts.
- GitHub connector mutations are structurally available but policy-gated.
- Wix connector remains `PLAN_ONLY_READY`; no dedicated project MCP client config is evidenced.
- Claude Desktop and Cursor local MCP configs are `NOT_CONFIGURED`.

## Orchestrator classification

```text
MCP_RUNTIME_CLIENT_CONFIG_EVIDENCE_RECEIVED
MCP_RUNTIME_CLIENT_CONFIG_EVIDENCE_INDEXED
RAW_CREDENTIAL_VALUES_NOT_DETECTED_BY_PATTERN_SCAN
LIVE_HTTP_CHECK_NOT_PERFORMED_IN_PACKAGE
LOCAL_CLIENT_CONFIGS_NOT_EVIDENCED_FOR_CLAUDE_OR_CURSOR
NO_LIVE_WRITE_APPROVAL
```

## Supersedes / refreshes

This evidence refresh supersedes the earlier MCP runtime/client config intake file for operational status tracking, while preserving the older file as historical evidence:

```text
docs/evidence/MCP_RUNTIME_CONFIG_EVIDENCE_INTAKE_1138_02072026.md
```

## Next required action

Use this refresh to align the orchestrator runtime/client evidence tracker and the provider adapter registry. Do not enable live provider writes, DNS writes, SQL writes, accounting writes, production deployment, destructive operations, or direct provider publish actions from this evidence alone.
