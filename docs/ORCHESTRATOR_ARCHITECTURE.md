# Orchestrator Architecture — 01:55, 29.06.2026

## Purpose

The NTSN Orchestrator Control Plane coordinates existing GitHub-based execution environments and external provider control surfaces.

## Operating model

```text
ChatGPT / Custom GPTs
  -> Orchestrator control repository
  -> Managed subsystem repositories
  -> GitHub Actions validation/reporting
  -> External provider operations only after explicit approval
```

## Repository boundaries

The orchestrator repository does not replace subsystem repositories. It references them and maintains the routing, approval, and evidence model.

## Managed layers

| Layer | Repository or provider | Function |
|---|---|---|
| PowerShell | `nanotech-solutions-norway/Powershell-` | PowerShell execution and reporting |
| Python | `nanotech-solutions-norway/Phyton` | Python execution and validation |
| Domeneshop MCP | `nanotech-solutions-norway/Domeneshop---MCP-` | Domeneshop bridge and deployment planning |
| Conta MCP | `nanotech-solutions-norway/Conta-MCP` | Accounting bridge environment |
| Memory/audit | `nanotech-solutions-norway/ai-memory-ops` | Approved context and evidence references |
| Wix | external provider | DNS and domain records when Wix nameservers are authoritative |
| Domeneshop | external provider | registrar, server, FTP/SFTP, and SQL hosting functions |

## Current posture

```text
READ_ONLY_REPORTING_ONLY
NO_AUTONOMOUS_LIVE_CHANGE
PROVIDER_WRITES_REQUIRE_APPROVAL
```
