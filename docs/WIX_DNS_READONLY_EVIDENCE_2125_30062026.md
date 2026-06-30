# Wix DNS Read-Only Evidence — 21:25, 30.06.2026

## Scope

This report records DNS information retrieved using the enabled Wix connector in read-only mode.

## Classification

```text
EVIDENCE_COLLECTED
READ_ONLY
NO_DNS_WRITE_APPROVAL
NO_AUTONOMOUS_LIVE_CHANGE
```

## Connected domains returned by Wix

| Domain | Connection type | Propagation status | DNS zone retrieval |
|---|---|---:|---:|
| `atlas-ai.no` | NAMESERVERS | COMPLETED | Retrieved |
| `ainorge.com` | NAMESERVERS | COMPLETED | Retrieved |
| `nanoconcept.no` | NAMESERVERS | FAILED | Retrieved |
| `airlite.no` | NAMESERVERS | COMPLETED | Retrieved |
| `nanotech-solutions.com` | NAMESERVERS | COMPLETED | Retrieved |
| `onyx-norge.no` | NAMESERVERS | FAILED | Retrieved |
| `ntsn.no` | NAMESERVERS | COMPLETED | Not retrieved: connector safety block |

`solarex.no` was not returned by the Wix connected-domain inventory.

## Key findings

### `atlas-ai.no`

- Authoritative DNS: Wix.
- DNSSEC: disabled.
- Apex A records point to Wix IPs: `185.230.63.171`, `185.230.63.186`, `185.230.63.107`.
- Nameservers: `ns10.wixdns.net`, `ns11.wixdns.net`.
- `mcp.atlas-ai.no`, `monitor.atlas-ai.no`, and `pip.atlas-ai.no` point to `194.63.249.234`.
- Verification TXT records are present but redacted in repository evidence.

### `nanotech-solutions.com`

- Authoritative DNS: Wix.
- DNSSEC: enabled.
- Apex A records point to Wix IPs: `185.230.63.107`, `185.230.63.186`, `185.230.63.171`.
- Nameservers: `ns11.wixdns.net`, `ns10.wixdns.net`.
- MX routes to Domeneshop: `0 mx.domeneshop.no`.
- SPF references Domeneshop: `v=spf1 include:_spf.domeneshop.no ~all`.
- `forms.nanotech-solutions.com` points to `194.63.249.211`.
- Verification TXT records are present but redacted in repository evidence.

### `ainorge.com`

- Authoritative DNS: Wix.
- DNSSEC: disabled.
- Apex A records point to Wix IPs.
- Nameservers: `ns10.wixdns.net`, `ns11.wixdns.net`.
- SPF is `v=spf1 -all`.
- Review note: MX value was returned as blank after priority `0`.

### `airlite.no`

- Authoritative DNS: Wix.
- DNSSEC: disabled.
- Apex A records point to Wix IPs.
- Nameservers: `ns11.wixdns.net`, `ns10.wixdns.net`.

### `nanoconcept.no`

- Authoritative DNS: Wix.
- Wix propagation status: failed.
- DNSSEC: disabled.
- Apex A records point to Wix IPs.
- MX routes to Domeneshop: `10 mx.domeneshop.no`.
- SPF references Domeneshop.
- Follow-up required: public DNS lookup and registrar/nameserver validation.

### `onyx-norge.no`

- Authoritative DNS: Wix.
- Wix propagation status: failed.
- DNSSEC: disabled.
- Apex A records point to Wix IPs.
- Follow-up required: public DNS lookup and registrar/nameserver validation.

### `ntsn.no`

- Listed by Wix as NAMESERVERS with propagation completed.
- DNS zone retrieval was blocked by connector safety layer.
- Follow-up required: retry via Wix connector or upload/export DNS zone evidence.

### `solarex.no`

- Not returned by Wix connected-domain inventory.
- Follow-up required: confirm current DNS authority outside Wix or add to Wix evidence map after verified export.

## Follow-up requirements

1. Run public DNS lookup for `nanoconcept.no` and `onyx-norge.no`.
2. Retry or manually export `ntsn.no` DNS zone evidence.
3. Confirm `solarex.no` DNS authority.
4. Do not apply DNS changes until operator approval is recorded.
