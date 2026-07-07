# Protected Endpoint Operator Execution Runbook

## Scope

Use this runbook for O-RT12 operator-local readiness checks.

## Pre-checks

```text
Use local workstation or controlled read-only runner.
Do not commit request material.
Commit sanitized result summaries only.
Mark uncertain results as PENDING_REVIEW.
```

## Public health check pattern

```powershell
$Uri = '<public-health-url>'
$response = Invoke-WebRequest -Method GET -Uri $Uri -UseBasicParsing
$response.StatusCode
```

Record only:

```text
status code
status class
timestamp
short sanitized note
```

## Protected status check pattern

```powershell
$Uri = '<protected-status-url>'
$Headers = @{
  'Authorization' = 'Bearer <operator-local-token-not-logged>'
}
$response = Invoke-WebRequest -Method GET -Uri $Uri -Headers $Headers -UseBasicParsing
$response.StatusCode
```

Before saving output, remove request headers and response bodies unless the response is already a public, non-sensitive status message.

## Repository readiness check pattern

```powershell
./tests/Test-OrchestratorValidationSuite.ps1
```

## Result file

Use:

```text
templates/protected-endpoint-validation/PROTECTED_ENDPOINT_RESULT_TEMPLATE.json
```

## Review rule

Only sanitized summaries may be submitted for repository intake.
