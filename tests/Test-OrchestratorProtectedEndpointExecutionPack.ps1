# Test-OrchestratorProtectedEndpointExecutionPack.ps1
# O-RT12 protected endpoint validation execution pack test.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/ORT12_PROTECTED_ENDPOINT_VALIDATION_EXECUTION_PACK_20260706.md',
    'config/protected-endpoint-validation-execution.yml',
    'templates/protected-endpoint-validation/PROTECTED_ENDPOINT_OPERATOR_EXECUTION_RUNBOOK.md',
    'templates/protected-endpoint-validation/PROTECTED_ENDPOINT_RESULT_TEMPLATE.json',
    'examples/protected-endpoint-validation/sample_sanitized_validation_result.json'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing O-RT12 required file: $file"
    }
}

$policy = Get-Content (Join-Path $RepoRoot 'config/protected-endpoint-validation-execution.yml') -Raw
foreach ($marker in @(
    'release_train: O-RT12',
    'mode: PROTECTED_ENDPOINT_VALIDATION_EXECUTION_PACK',
    'repository_endpoint_calls_allowed: false',
    'live_write_approved: false',
    'result_storage_policy: sanitized_summary_only',
    'unknown_result_default: PENDING_REVIEW'
)) {
    if ($policy -notmatch [regex]::Escape($marker)) {
        throw "O-RT12 policy missing marker: $marker"
    }
}

foreach ($target in @(
    'domeneshop_mcp_public_health',
    'domeneshop_mcp_status',
    'conta_mcp',
    'ntsn_orchestrator_control_plane'
)) {
    if ($policy -notmatch [regex]::Escape($target)) {
        throw "O-RT12 policy missing validation target: $target"
    }
}

$template = Get-Content (Join-Path $RepoRoot 'templates/protected-endpoint-validation/PROTECTED_ENDPOINT_RESULT_TEMPLATE.json') -Raw | ConvertFrom-Json
foreach ($field in @('validationId','releaseTrain','targetId','category','timestampUtc','operator','resultClass','httpStatus','statusSummary','evidenceReference','followUpRequired','sanitizationConfirmed')) {
    if (-not ($template.PSObject.Properties.Name -contains $field)) {
        throw "O-RT12 result template missing field: $field"
    }
}

$sample = Get-Content (Join-Path $RepoRoot 'examples/protected-endpoint-validation/sample_sanitized_validation_result.json') -Raw | ConvertFrom-Json
if ($sample.releaseTrain -ne 'O-RT12') {
    throw 'Sample result releaseTrain must be O-RT12.'
}
if ($sample.sanitizationConfirmed -ne $true) {
    throw 'Sample result must confirm sanitization.'
}

Write-Host 'PASSED: O-RT12 protected endpoint execution pack verified.'
