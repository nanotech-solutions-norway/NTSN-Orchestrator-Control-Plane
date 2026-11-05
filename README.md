# NTSN Orchestrator Control Plane — 01:55, 29.06.2026

This repository is the cross-system orchestration, routing, approval, and evidence-control layer for NanoTech Solutions Norway operational environments.

## Repository identity

| Item | Value |
|---|---|
| Repository | `nanotech-solutions-norway/NTSN-Orchestrator-Control-Plane` |
| Role | Cross-repository orchestrator control plane |
| Execution model | ChatGPT orchestrates; GitHub Actions executes bounded validation and reporting |
| Initial posture | Read-only, report-driven, no live writes |
| Provider writes | Out of scope until separately approved |

## Managed subsystem repositories

| Subsystem | Repository | Current function |
|---|---|---|
| PowerShell execution | `nanotech-solutions-norway/Powershell-` | PowerShell GitHub Actions execution/control layer |
| Python execution | `nanotech-solutions-norway/Phyton` | Python GitHub Actions execution/testing/debugging layer |
| Domeneshop MCP | `nanotech-solutions-norway/Domeneshop---MCP-` | Domeneshop MCP bridge system of record |
| Conta MCP | `nanotech-solutions-norway/Conta-MCP` | Conta/accounting MCP bridge environment |
| Memory/audit | `nanotech-solutions-norway/ai-memory-ops` | Governed memory, decisions, errors, actions, evidence |

## Purpose

This repository coordinates existing environments without absorbing them. It holds repository routing rules, approval policy, evidence requirements, connector capability mapping, DNS authority documentation, workflow routing documentation, cross-system readiness reports, and production-write gate rules.

## Current operating decision

```text
ORCHESTRATOR_BASELINE_CREATED
READ_ONLY_REPORTING_ONLY
NO_PROVIDER_WRITES
NO_AUTONOMOUS_LIVE_CHANGE
PENDING_EVIDENCE_INTAKE
```

## Baseline validation

The initial workflow is:

```text
Orchestrator Readiness
```

It validates that required baseline files exist and that the repository remains read-only/report-driven at initialization.

## ChatGPT-first MCP creation — proposed greenfield route (05.11.2026)

For **new, isolated, synthetic-data** MCP server designs, consult the central draft [ChatGPT-first MCP development playbook](https://github.com/nanotech-solutions-norway/ntsn-mcp-integrations/pull/97) derived from the 04.11.2026 Clean-Sheet Deep Research report. It evaluates **ChatGPT Work + Plugin Creator + ChatGPT Sites + durable D1** as the lowest-friction first prototype, conditional on actual feature availability, and **GitHub + Codex Cloud + Cloudflare Workers/D1** for source-controlled portable deployment. A new MCP App UI and centralized gateway remain optional.

This is **documentation under review**, not proof of Sites access, a deployable code sample, a native ChatGPT command, production authorization, OAuth configuration, integration replacement or runtime activation. The source report's illustrative idempotency flow is not atomic and its SDK auth-context lookup is unverified; require implementation and negative/transaction tests before any deploy. Existing universal/2026-07-28 MCP security, actual provider permissions, local source-control authority and project-specific locks prevail. **Preserve current source/runtime-client alignment and protected endpoint verification gates; no production dispatch.**
