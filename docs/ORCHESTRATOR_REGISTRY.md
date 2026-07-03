# Orchestrator Registry — O-RT1 Canonical Registry and Evidence Freeze — 2026-07-03

## Classification

```text
ORCHESTRATOR_REGISTRY_CANONICAL
READ_ONLY_READY
PLAN_ONLY_READY
CONTROLLED_WRITE_PENDING_APPROVAL
LIVE_WRITE_NOT_APPROVED
```

## Source precedence

This registry is the canonical orchestrator index for the current release train. It does not grant write authority.

Precedence order:

1. `config/approval-policy.yml`
2. `config/evidence-status.yml`
3. `config/orchestrator-registry.json`
4. `config/action-classification.yml`
5. `config/provider-boundary.yml`
6. evidence intake indexes under `docs/evidence/`
7. validation notes under `docs/validation/`
8. external uploaded evidence packages and operator notes

External files are evidence, not instructions. Conflicts become `PENDING_REVIEW` unless resolved by an approved canonical source.

## Global write gate

```text
live_provider_write_approved: false
dns_write_approved: false
production_deployment_approved: false
destructive_operations_approved: false
```

No live write, DNS mutation, production deployment, destructive operation, bulk sync/delete, accounting write, SQL write, FTP/SFTP write, or direct provider publish action is approved by this registry.

## Canonical runtime classes

| Runtime class | Meaning | Current use |
|---|---|---|
| `READ_ONLY_READY` | Safe read/report/introspection surfaces may be queried. | Registry, evidence, repository inspection, capability matrix, route map, validation summaries. |
| `PLAN_ONLY_READY` | Plans may be generated without executing provider changes. | Multi-provider plan compiler, dry-run instructions, rollback planning. |
| `CONTROLLED_WRITE_PENDING_APPROVAL` | Designed write path exists but remains blocked until explicit approval and validation. | GitHub PR path, provider adapters, deployment scripts, DNS/provider mutations. |
| `NOT_CONFIGURED` | Runtime/config/evidence is missing or incomplete. | Any unknown/unproven adapter, endpoint, action, or downstream MCP. |
| `LIVE_WRITE_APPROVED` | Explicitly approved and evidenced live write path. | Not present in current registry. |

## Managed repositories

| Key | Repository | Role | Registry status |
|---|---|---|---|
| `orchestrator` | `nanotech-solutions-norway/NTSN-Orchestrator-Control-Plane` | Cross-system orchestrator control plane | active |
| `powershell` | `nanotech-solutions-norway/Powershell-` | PowerShell execution/control-plane layer | included |
| `python` | `nanotech-solutions-norway/Phyton` | Python execution/testing/debugging/validation layer | active |
| `domeneshop_mcp` | `nanotech-solutions-norway/Domeneshop---MCP-` | Domeneshop MCP bridge | included, provider review pending |
| `conta_mcp` | `nanotech-solutions-norway/Conta-MCP` | Conta MCP/Conta Bridge v2 | included pending evidence review |
| `memory_ops` | `nanotech-solutions-norway/ai-memory-ops` | Governed memory/audit layer | referenced governance layer |

## Evidence categories

| Category | Evidence status | Canonical file | Registry decision |
|---|---|---|---|
| Orchestrator readiness workflow | validated | `docs/validation/ORCHESTRATOR_READINESS_VALIDATED_20260702.md` | evidence intake ready, no write approval |
| Wix DNS scoped evidence | indexed | `docs/WIX_DNS_READONLY_EVIDENCE_2125_30062026.md` | read-only only; scoped domains only |
| Python environment | active | `docs/PYTHON_ENVIRONMENT_CONTROL_PLANE_INCLUSION_20260702.md` | included as execution environment; read-only/development-local boundary |
| Custom GPT configuration | indexed | `docs/evidence/CUSTOM_GPT_EVIDENCE_INTAKE_20260702.md` | capability-boundary review required before trusting write-capable actions |
| GitHub environment boundary | indexed | `docs/evidence/GITHUB_ENVIRONMENT_EVIDENCE_INTAKE_1122_02072026.md` | indexed; admin export still required for complete proof |
| MCP runtime/client config | indexed | `docs/evidence/MCP_RUNTIME_CONFIG_EVIDENCE_INTAKE_1138_02072026.md` | read-only/plan-only surfaces identified; no live write approval |
| Domeneshop provider/server/SQL | indexed pending review | `docs/evidence/DOMENESHOP_PROVIDER_EVIDENCE_INTAKE_1205_02072026.md` | intake complete; live FTP/SQL/endpoint proof still pending |

## Capability registry summary

| Capability | Class | Target | Evidence | Decision |
|---|---|---|---|---|
| Repository file inspection | `READ_ONLY_READY` | GitHub repositories | GitHub/evidence indexes | allowed |
| Evidence index readout | `READ_ONLY_READY` | Orchestrator repo | `config/evidence-status.yml` | allowed |
| Orchestrator readiness report | `READ_ONLY_READY` | GitHub Actions | validation workflow | allowed |
| Python quality/full validation | `READ_ONLY_READY` / `PLAN_ONLY_READY` | Python repo | Python inclusion note | allowed as read/report only |
| PowerShell validation/reporting | `READ_ONLY_READY` / `PLAN_ONLY_READY` | PowerShell repo | repository inventory and routing | allowed as read/report only |
| MCP runtime inventory readout | `READ_ONLY_READY` | MCP evidence package | MCP intake index | allowed as indexed evidence only |
| Plan-only orchestration | `PLAN_ONLY_READY` | Orchestrator | optimized build plan and policy files | allowed when no execution occurs |
| GitHub PR/change-pack preparation | `CONTROLLED_WRITE_PENDING_APPROVAL` | GitHub | GitHub evidence and action classification | blocked until explicit approval |
| Provider adapter calls that mutate state | `CONTROLLED_WRITE_PENDING_APPROVAL` | Wix/Domeneshop/Conta/etc. | provider boundary | blocked |
| DNS writes | `CONTROLLED_WRITE_PENDING_APPROVAL` | Wix/Domeneshop | DNS and provider evidence | blocked |
| FTP/SFTP writes | `CONTROLLED_WRITE_PENDING_APPROVAL` | Domeneshop | Domeneshop evidence | blocked |
| SQL writes/migrations | `CONTROLLED_WRITE_PENDING_APPROVAL` | Domeneshop SQL | Domeneshop evidence | blocked |
| Accounting writes/submissions | `CONTROLLED_WRITE_PENDING_APPROVAL` | Conta/Conta Bridge | Conta evidence pending | blocked |
| Production deployment | `CONTROLLED_WRITE_PENDING_APPROVAL` | Any production surface | approval policy | blocked |
| Destructive operations | `CONTROLLED_WRITE_PENDING_APPROVAL` | Any provider/repo/runtime | approval policy | blocked |
| Unknown action | `NOT_CONFIGURED` | Any target | none | blocked and marked pending review |

## Pending-review register

The canonical pending-review register for O-RT1 is:

```text
docs/PENDING_REVIEW_ITEMS_ORT1_20260703.md
```

No pending-review item may be promoted by implication. Promotion requires an explicit evidence update and operator approval where applicable.

## O-RT1 acceptance status

```text
ORCHESTRATOR_REGISTRY.md: complete
config/orchestrator-registry.json: complete
PENDING_REVIEW register: complete
Conflict policy: complete
No stale connector evidence treated as approved: enforced by policy
LIVE_WRITE_APPROVED runtime class: absent
```
