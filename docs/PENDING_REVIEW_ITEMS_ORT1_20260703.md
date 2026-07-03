# Pending Review Items — O-RT1 — 2026-07-03

## Purpose

This file freezes unresolved or conflicting evidence into an explicit `PENDING_REVIEW` register. Nothing in this file is approved for live execution by implication.

## Global rule

```text
PENDING_REVIEW != APPROVED
PENDING_REVIEW != LIVE_WRITE_APPROVED
```

## Pending-review items

| ID | Area | Item | Owner / review path | Required resolution | Current action class |
|---|---|---|---|---|---|
| `ORT1-PR-001` | Custom GPT | Custom GPT Orchestrator v1.2 text | Operator / GPT Builder review | Confirm current visible instruction set and capability boundary | `PENDING_REVIEW` |
| `ORT1-PR-002` | Custom GPT | Project Orchestrator v1.2 text | Operator / GPT Builder review | Confirm current visible instruction set and conflict with canonical policy | `PENDING_REVIEW` |
| `ORT1-PR-003` | Domeneshop MCP | Domeneshop MCP schemas | Repo/API schema review | Confirm current schema, methods, auth, read/write classification | `PENDING_REVIEW` |
| `ORT1-PR-004` | PowerShell | Deployment scripts | PowerShell repo review | Confirm script registry, write paths, dry-run support, and environment gate | `PENDING_REVIEW` |
| `ORT1-PR-005` | GitHub | Live action schemas | GitHub admin/connector evidence | Confirm exact current action schemas and write scopes | `PENDING_REVIEW` |
| `ORT1-PR-006` | Wix | Live action schemas | Wix connector/admin export | Confirm exact current action schemas and provider write scope | `PENDING_REVIEW` |
| `ORT1-PR-007` | GitHub | Full environment protection proof | GitHub admin export | Confirm branch rules, required reviewers, env protections, and secret names only | `PENDING_ADMIN_EXPORT` |
| `ORT1-PR-008` | Domeneshop | Live FTP/SFTP tree | Operator / provider export | Confirm current live file tree against sanitized expected evidence | `PENDING_REVIEW` |
| `ORT1-PR-009` | Domeneshop SQL | Full metadata schema | phpMyAdmin/SQL metadata export | Confirm columns, types, PK/FK/indexes, constraints, views/routines if present | `PENDING_REVIEW` |
| `ORT1-PR-010` | Domeneshop endpoints | Live endpoint crawl | Operator-controlled validation | Confirm current HTTP statuses without secrets/private payloads | `PENDING_REVIEW` |
| `ORT1-PR-011` | Conta MCP | Write-control evidence | Conta MCP repo/phase evidence | Confirm no live accounting write/submission path is exposed | `PENDING_REVIEW` |
| `ORT1-PR-012` | Memory layer | Memory write-back behavior | ai-memory-ops review | Confirm memory writes are governed and cannot bypass approval | `PENDING_REVIEW` |

## Out-of-scope DNS items

By user instruction on 2026-07-02, the following domains are excluded from current DNS readiness follow-up:

```text
solarex.no
nanoconcept.no
onyx-norge.no
ntsn.no
```

They may be reintroduced only by explicit user instruction and fresh evidence.

## Promotion requirements

A pending item may be promoted only when all applicable conditions are met:

1. canonical evidence file is updated;
2. source is identified;
3. stale/conflicting evidence is resolved;
4. write class remains blocked unless explicitly approved;
5. validation evidence is recorded;
6. rollback/disable plan exists for any future controlled write path.

## Current outcome

```text
PENDING_REVIEW_ITEMS_FROZEN
NO_PENDING_ITEM_APPROVED_FOR_LIVE_WRITE
```
