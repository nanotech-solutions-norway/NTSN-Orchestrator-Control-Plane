# Protected Endpoint Operator Execution Runbook

## Scope

Use this runbook for O-RT12 operator-local readiness checks.

## Pre-checks

```text
Use local workstation or controlled read-only runner.
Commit sanitized result summaries only.
Mark uncertain results as PENDING_REVIEW.
```

## Preferred wrapper

Use the repository wrapper:

```powershell
./tools/protected-endpoint-validation/Invoke-ProtectedEndpointValidation.ps1 \
  -TargetId '<target-id>' \
  -Category '<public_health/protected_status/protected_mcp>' \
  -Uri '<endpoint-url>' \
  -OutputPath './artifacts/protected-endpoint-validation/<target-id>.json'
```

For a protected endpoint, set the auth value only in the local terminal environment and pass the variable name:

```powershell
$env:LOCAL_ENDPOINT_TOKEN = '<enter-locally-only>'

./tools/protected-endpoint-validation/Invoke-ProtectedEndpointValidation.ps1 \
  -TargetId '<target-id>' \
  -Category 'protected_status' \
  -Uri '<endpoint-url>' \
  -AuthEnvVarName 'LOCAL_ENDPOINT_TOKEN' \
  -OutputPath './artifacts/protected-endpoint-validation/<target-id>.json'
```

## Public health check pattern

```powershell
./tools/protected-endpoint-validation/Invoke-ProtectedEndpointValidation.ps1 \
  -TargetId 'domeneshop_mcp_public_health' \
  -Category 'public_health' \
  -Uri '<public-health-url>'
```

## Protected status check pattern

```powershell
./tools/protected-endpoint-validation/Invoke-ProtectedEndpointValidation.ps1 \
  -TargetId 'domeneshop_mcp_status' \
  -Category 'protected_status' \
  -Uri '<protected-status-url>' \
  -AuthEnvVarName 'LOCAL_ENDPOINT_TOKEN'
```

## Repository readiness check pattern

```powershell
./tests/Test-OrchestratorValidationSuite.ps1
```

## Result file

The wrapper writes only the result fields defined in:

```text
templates/protected-endpoint-validation/PROTECTED_ENDPOINT_RESULT_TEMPLATE.json
```

## Review rule

Only sanitized summaries may be submitted for repository intake.
