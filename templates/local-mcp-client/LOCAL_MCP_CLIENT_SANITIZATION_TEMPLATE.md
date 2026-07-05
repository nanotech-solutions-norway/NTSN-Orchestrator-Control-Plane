# Local MCP Client Sanitization Template

## Target client

```text
<claude-desktop-local-mcp or cursor-local-mcp>
```

## Required JSON structure

```json
{
  "clientId": "<client-id>",
  "clientName": "<client-name>",
  "configLocationClass": "<user_config_directory / workspace_config / unknown>",
  "serverEntries": [
    {
      "serverName": "<server-name>",
      "commandOrUrlClass": "<local_command / remote_url / disabled / unknown>",
      "argsSanitized": ["<argument-name-or-placeholder>"],
      "envVariableNamesOnly": ["<ENV_VAR_NAME_ONLY>"],
      "enabledStatus": "<enabled / disabled / not_configured / unknown>",
      "notes": "<sanitized notes>"
    }
  ],
  "evidenceTimestamp": "<YYYY-MM-DDTHH:mm:ssZ>",
  "sanitizationConfirmed": true,
  "secretsIncluded": false
}
```

## Remove before sharing

```text
actual token values
actual password values
actual key values
private headers
full .env contents
private payloads
account/customer data
```

## Allowed

```text
server names
environment variable names only
command category or URL category
sanitized argument placeholders
enabled/disabled status
capture timestamp
```
