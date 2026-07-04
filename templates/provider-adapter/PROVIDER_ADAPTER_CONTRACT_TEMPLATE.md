# Provider Adapter Contract Template

## Metadata

| Field | Value |
|---|---|
| Adapter ID | `<adapterId>` |
| Provider | `<provider>` |
| Release train | `O-RT6` |
| Runtime class | `<runtimeClass>` |
| Execution allowed by default | `false` |

## Capabilities

### Read capabilities

```text
<read capabilities>
```

### Plan-only capabilities

```text
<plan-only capabilities>
```

### Write capabilities

```text
<write capabilities or none>
```

## Approval and dry-run behavior

```text
Approval required for write: true
Dry-run supported: <true/false>
Audit required: true
Fallback on unknown: <NOT_CONFIGURED/PENDING_REVIEW>
```

## Forbidden action categories

```text
<forbidden categories>
```

## Evidence sources

```text
<canonical evidence files>
```

## Adapter boundary

This adapter may not exceed its declared runtime class or the canonical provider boundary. If adapter evidence conflicts with `config/provider-boundary.yml`, `config/action-classification.yml`, or `config/evidence-status.yml`, the stricter classification applies and the action must be marked `PENDING_REVIEW`.

## Current status

```text
ADAPTER_CONTRACT_DEFINED
LIVE_WRITE_NOT_APPROVED
ADAPTER_BYPASS_NOT_ALLOWED
```
