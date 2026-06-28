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
