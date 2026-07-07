# Protected Endpoint Validation Results

## Purpose

This folder is reserved for sanitized O-RT12 operator-produced endpoint validation result JSON files.

## Current status

```text
NO_REAL_OPERATOR_RESULTS_INGESTED_YET
```

## Expected files

One JSON result file per target, for example:

```text
domeneshop_mcp_public_health.json
domeneshop_mcp_status.json
conta_mcp.json
ntsn_orchestrator_control_plane.json
```

## Required schema

```text
schemas/protected-endpoint-validation-result.schema.json
```

## Rule

Only sanitized result summaries may be committed here.
