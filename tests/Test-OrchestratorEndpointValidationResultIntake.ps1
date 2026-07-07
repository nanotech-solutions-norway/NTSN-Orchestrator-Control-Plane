# Test-OrchestratorEndpointValidationResultIntake.ps1
# O-RT13 endpoint validation result intake framework test.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/ORT13_ENDPOINT_VALIDATION_RESULT_INTAKE_20260706.md',
    'config/protected-endpoint-result-intake.yml',
    'schemas/protected-endpoint-validation-result.schema.json',
    'evidence/protected-endpoint-results/README.md',
    'examples/protected-endpoint-validation/sample_result_intake_manifest.json'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing O-RT13 required file: $file"
    }
}

$config = Get-Content (Join-Path $RepoRoot 'config/protected-endpoint-result-intake.yml') -Raw
foreach ($marker in @(
    'release_train: O-RT13',
    'mode: ENDPOINT_VALIDATION_RESULT_INTAKE',
    'repository_endpoint_calls_allowed: false',
    'live_write_approved: false',
    'intake_location: evidence/protected-endpoint-results',
    'unknown_result_default: PENDING_REVIEW'
)) {
    if ($config -notmatch [regex]::Escape($marker)) {
        throw "O-RT13 intake config missing marker: $marker"
    }
}

foreach ($target in @('domeneshop_mcp_public_health','domeneshop_mcp_status','conta_mcp','ntsn_orchestrator_control_plane')) {
    if ($config -notmatch [regex]::Escape($target)) {
        throw "O-RT13 intake config missing target: $target"
    }
}

$schema = Get-Content (Join-Path $RepoRoot 'schemas/protected-endpoint-validation-result.schema.json') -Raw | ConvertFrom-Json
if ($schema.properties.sanitizationConfirmed.const -ne $true) {
    throw 'O-RT13 result schema must require sanitizationConfirmed true.'
}

$manifest = Get-Content (Join-Path $RepoRoot 'examples/protected-endpoint-validation/sample_result_intake_manifest.json') -Raw | ConvertFrom-Json
if ($manifest.releaseTrain -ne 'O-RT13') {
    throw 'O-RT13 manifest releaseTrain must be O-RT13.'
}
if ($manifest.realOperatorResultsIngested -ne $false) {
    throw 'Sample manifest must not claim real operator results were ingested.'
}

Write-Host 'PASSED: O-RT13 endpoint validation result intake framework verified.'
