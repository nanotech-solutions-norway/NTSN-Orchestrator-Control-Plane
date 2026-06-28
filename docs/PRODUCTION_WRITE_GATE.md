# Production Write Gate — 01:55, 29.06.2026

## Purpose

This document defines the live-change boundary for the orchestrator.

## Default state

```text
NO_AUTONOMOUS_LIVE_CHANGE
PROVIDER_WRITES_REQUIRE_OPERATOR_SIGNOFF
DESTRUCTIVE_ACTIONS_REQUIRE_OPERATOR_SIGNOFF
```

## Pending-review actions

The following action classes require explicit approval:

- DNS changes;
- server file upload or removal;
- database migration;
- write-tool activation;
- production deployment;
- destructive operation.

## Required preconditions

Before any live change:

1. evidence pack complete;
2. dry-run or plan complete;
3. rollback note available;
4. operator approval recorded;
5. validation workflow available.

## Current status

```text
LIVE_CHANGE_NOT_APPROVED
```
