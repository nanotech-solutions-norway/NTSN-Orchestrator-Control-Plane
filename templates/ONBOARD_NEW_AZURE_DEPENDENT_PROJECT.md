# Checklist — new NTSN project that uses Microsoft Azure

**Applied to:** any new GitHub repository or project proposing Azure hosting, Azure CI services or managed Azure data services. **Canonical policy:** `governance/AZURE_PRICING_SOURCE_OF_TRUTH.md` in the organization's central integration baseline (private `ntsn-mcp-integrations`).

## Pre-implementation setup

- [ ] Reference the canonical organization-wide Azure source-of-truth policy in the new repo, pointing to the owner-restricted Google Drive folder titled `NTSN Azure Billing & Pricing — Restricted` by discovery name only (do not publish commercial rates or private Drive file/share identifiers).
- [ ] Determine whether the project's chosen Azure subscription is one of the active subscription plans in the private registry. Do not auto-bind based on similar names.
- [ ] Retrieve the **current-month** price sheet through approved private Google Drive data sources and verify archive SHA-256 against private manifest; do not re-request an existing file from the operator.
- [ ] If the current month is missing, check whether an **authorized**, read-only Azure billing-profile Cost Management price-sheet API refresh is available; otherwise mark `ACCOUNT_RATE_SOURCE_STALE`, use public Azure Retail API for estimates only and escalate *genuine* need for account access.
- [ ] Confirm service SKUs, pricing region, meter IDs, tier thresholds, full period, credits, taxes, billing exchange rate, ancillary charges, VNet/LB/IP, storage and post-delete tails. Set a project-specific budget.
- [ ] Confirm minimum-required read-only billing identity separately from deployment identity and from existing GitHub read-only preflight identities. Do not create Contributor/Owner credentials for rate lookup.
- [ ] Have an independent reviewer verify the actual budget, security, data boundary, teardown and alert limitations before *any* Azure write authorization.
- [ ] Link the project to current data-source version and signed decision; private negotiated values remain in restricted Drive/approved secure compute, not repository source history, issues, logs or build artifacts.

## Ongoing monitoring & governance
On repository creation and on major budget or infrastructure modifications, automation should scan for Azure dependencies and missing policy reference, and open a review PR. This orchestration is **not automatically active** just because the template exists. To activate, assign a narrowly scoped GitHub App with organization-repository enumeration, PR-content permissions and a scheduled audit, then independently verify the automation and branch-protection checks. Azure billing-profile rate refresh additionally requires a **distinct authorized billing-scoped identity**.

**Stop rule:** when source authority, period freshness, subscription binding and independent project budget/security approval are validated, mark each gate complete and stop adding additional process. If current rates/identity are unavailable, hold deployment without fabricating rates or demanding a duplicate October upload.
