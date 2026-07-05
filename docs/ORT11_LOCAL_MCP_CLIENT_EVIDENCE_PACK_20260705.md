# O-RT11 Local MCP Client Evidence Pack — 2026-07-05

## Release train

```text
O-RT11 — Local MCP Client Evidence Pack
```

## Classification

```text
LOCAL_CLIENT_EVIDENCE_PACK
PENDING_EVIDENCE
NOT_CONFIGURED
PLAN_ONLY_READY
LIVE_WRITE_NOT_APPROVED
```

## Purpose

O-RT11 addresses the missing sanitized local MCP client evidence for:

```text
claude-desktop-local-mcp
cursor-local-mcp
```

The refreshed MCP runtime/client evidence package from 12:33, 04.07.2026 records both local clients as not evidenced. O-RT11 creates the safe collection framework, examples, and validation test for future sanitized evidence intake.

## Important boundary

This phase does not infer that Claude Desktop or Cursor are configured. It does not request, store, or expose protected values. It only defines how the user can provide sanitized evidence later.

## Required source files

```text
config/local-mcp-client-evidence.yml
templates/local-mcp-client/LOCAL_MCP_CLIENT_SANITIZATION_TEMPLATE.md
examples/local-mcp-client/claude_desktop_sanitized_example.json
examples/local-mcp-client/cursor_sanitized_example.json
tests/Test-OrchestratorLocalClientEvidencePack.ps1
```

## Required sanitized evidence fields

Each local client evidence entry should include:

| Field | Requirement |
|---|---|
| `clientId` | `claude-desktop-local-mcp` or `cursor-local-mcp`. |
| `clientName` | Human-readable client name. |
| `configLocationClass` | Location category only, not full private path if sensitive. |
| `serverEntries` | Server names and commands/URLs with values sanitized. |
| `envVariableNamesOnly` | Environment variable names only. |
| `enabledStatus` | enabled, disabled, not_configured, or unknown. |
| `evidenceTimestamp` | Date/time of evidence capture. |
| `sanitizationConfirmed` | Must be true. |
| `secretsIncluded` | Must be false. |

## Forbidden content

```text
API keys
bearer tokens
passwords
private headers
full .env values
private account payloads
full private absolute paths where unnecessary
```

## Current status

```text
CLAUDE_DESKTOP_LOCAL_MCP_PENDING_EVIDENCE
CURSOR_LOCAL_MCP_PENDING_EVIDENCE
NO_LOCAL_CLIENT_CONFIG_APPROVED
NO_LIVE_WRITE_APPROVAL
```

## Completion criteria

O-RT11 remains pending until sanitized config evidence is provided for one or both clients and indexed through a future evidence intake update.
