# MCP Runtime / Client Configuration Evidence Intake — 11:38, 02.07.2026

## Source package

Uploaded evidence package:

```text
NTSN_MCP_Runtime_Config_Evidence_1138_02072026.zip
```

Package SHA-256:

```text
91c4baf7a7a0194053b8e813424e060a529e98143fe81b387481573ae345df9d
```

## Sanitization status

The package states that secrets, bearer values, private headers, credential values, private runtime payloads, customer data, accounting exports, and full runtime configuration values are excluded. Environment/runtime values are represented only as sanitized names or categories in the source evidence. A local pattern scan found no obvious credential values.

## Files included in source package

| File | Size bytes | SHA-256 |
|---|---:|---|
| `MCP_RUNTIME_INVENTORY.md` | 8853 | `36f5a485b1b108f165529f61d455f81bec7f90b0e4bbdba1b3a2ef69bbddddd3` |
| `MCP_CLIENT_CONFIG_SANITIZED.json` | 8986 | `6934e3d33e63597dd42a2cf0b946cdef688076af7f1e2a7c44ac2a792cfc9d62` |
| `MCP_TOOL_REGISTRY.md` | 18307 | `e1b0d2756dd27f9f4f609bb71855f47e6c7c8ec284c1ee6867a7c3172b094f27` |
| `MCP_RUNTIME_HEALTH_REPORT.md` | 6273 | `ac6b00eb728effb474f5b01e159a104cd9ae54b64df1bbe058b941511dfef1b3` |
| `MCP_WRITE_CAPABILITY_AUDIT.md` | 11015 | `d6cec5fdf96f73e5e40b8b1ce782e1ea2d483824fef8e8cc05ac168f2ed57214` |

## Evidence sections detected

The package contains these evidence categories:

1. MCP/runtime inventory.
2. Sanitized client/runtime configuration index.
3. MCP tool registry.
4. Runtime health report.
5. Write-capability audit.

## Runtime and bridge categories identified

Detected evidence includes these runtime/control categories:

- NTSN Orchestrator Control Plane.
- Domeneshop MCP bridge.
- Conta MCP initial endpoint.
- Conta Bridge v2 / accounting bridge.
- Atlas AI monitor / PIP API bridge.
- SolarEX / NTSN forms SQL backend monitored target.
- PowerShell execution control plane.
- Python execution control plane.
- Memory Vault / governed memory and evidence layer.
- Atlas AI website/governance runtime.
- Wix connector boundary.

## Sanitized client/server entries detected

The sanitized client configuration contains 10 entries:

1. `domeneshop-mcp`
2. `domeneshop-mcp-powershell-launcher`
3. `conta-mcp-nanoconcept`
4. `conta-bridge-v2-atlas`
5. `atlas-pip-api-bridge`
6. `solarex-forms-sql-health-target`
7. `powershell-control-plane`
8. `python-control-plane`
9. `ai-memory-ops-memory-vault`
10. `wix-connector-atlas`

## Readiness classifications detected

Detected readiness classifications include:

```text
READ_ONLY_READY
PLAN_ONLY_READY
CONTROLLED_WRITE_PENDING_APPROVAL
NOT_CONFIGURED
```

No runtime in this extraction is classified as:

```text
LIVE_WRITE_APPROVED
```

## Write-capability summary

The write-capability audit identifies controlled or disabled write paths for DNS, server-file deployment, HTTP forwards, accounting draft/write actions, GitHub file writes, workflow-mediated operations, memory write-back, Wix/provider operations, and future SQL writes.

Current overall posture from the evidence package:

```text
READ_ONLY_READY for validated repository and read/report surfaces
PLAN_ONLY_READY for deployment, recovery, health, and preflight planning
CONTROLLED_WRITE_PENDING_APPROVAL for designed but disabled write paths
NOT_CONFIGURED where runtime values or write evidence are absent
LIVE_WRITE_NOT_APPROVED
```

## Orchestrator classification

```text
MCP_RUNTIME_CONFIG_EVIDENCE_RECEIVED
MCP_RUNTIME_CONFIG_EVIDENCE_INDEXED
RAW_CREDENTIAL_VALUES_NOT_DETECTED_BY_PATTERN_SCAN
READ_ONLY_AND_PLAN_ONLY_SURFACES_IDENTIFIED
CONTROLLED_WRITE_PATHS_REQUIRE_OPERATOR_APPROVAL
LIVE_WRITE_NOT_APPROVED
```

## Next required action

Use the MCP tool registry and write-capability audit to refine `config/action-classification.yml` and `config/provider-boundary.yml`. Do not enable live provider writes, DNS mutations, deployment writes, accounting writes, or SQL writes from this evidence alone.
