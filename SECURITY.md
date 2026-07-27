# Security Policy — 23:59, 27.07.2026

## Scope

This repository coordinates cross-repository routing, approvals, evidence and bounded validation. Its controlling posture is read-only/report-driven with no autonomous live change or provider writes.

## Prohibited content

Do not commit credentials, private keys, provider tokens, raw protected API payloads, customer-confidential material, accounting/bank data or sensitive personal data. The orchestrator must not become a secret store or customer-data repository.

## Reporting and response

Do not disclose secrets or confidential evidence in a public issue. Report privately to the owner. For suspected exposure: stop affected workflows, revoke and rotate outside GitHub, preserve evidence, remove unsafe artifacts, inspect cross-repository impact, assess notification duties and restore only after validation.

Changes to repository routing, approval gates, cross-system permissions, evidence controls or provider-write boundaries require controlled pull-request review. Repository transfer remains on hold.
