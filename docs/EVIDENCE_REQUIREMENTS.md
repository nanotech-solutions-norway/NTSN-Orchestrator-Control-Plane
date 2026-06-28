# Evidence Requirements — 01:55, 29.06.2026

## Purpose

This document defines the baseline evidence required before a subsystem is treated as ready by the orchestrator.

## Repository evidence

For each managed repository, collect:

- repository overview;
- workflow catalog;
- validation workflow names;
- latest validated baseline;
- expected artifacts;
- current operating boundary;
- failure-triage procedure.

## Provider evidence

For each external provider, collect:

- current authority boundary;
- current configuration summary;
- read-only validation result;
- planned change template;
- rollback note;
- operator signoff for live change.

## Readiness states

```text
PENDING_EVIDENCE
EVIDENCE_COLLECTED
READ_ONLY_READY
CONTROLLED_VALIDATION_READY
PENDING_OPERATOR_SIGNOFF
LIVE_CHANGE_APPROVED
```
