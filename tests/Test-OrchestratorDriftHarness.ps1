# Test-OrchestratorDriftHarness.ps1
# O-RT4 validation and drift harness baseline test.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/ORT4_VALIDATION_DRIFT_HARNESS_20260703.md',
    'config/drift-detection.yml',
    'reports/templates/ORCHESTRATOR_DRIFT_VALIDATION_REPORT_TEMPLATE.md',
    'config/evidence-status.yml',
    'docs/ORCHESTRATOR_REGISTRY.md',
    'config/orchestrator-registry.json',
    'config/read-only-routes.yml',
    'openapi/orchestrator-readonly.openapi.json',
    'config/provider-boundary.yml',
    'config/plan-only-policy.yml'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing required O-RT4 file: $file"
    }
}

$policy = Get-Content (Join-Path $RepoRoot 'config/drift-detection.yml') -Raw
foreach ($marker in @(
    'mode: VALIDATION_ONLY',
    'execution_allowed: false',
    'live_write_approved: false',
    'provider_calls_allowed: false',
    'workflow_dispatch_allowed: false'
)) {
    if ($policy -notmatch [regex]::Escape($marker)) {
        throw "Drift policy missing required marker: $marker"
    }
}

foreach ($severity in @('INFO', 'LOW', 'MEDIUM', 'HIGH', 'CRITICAL')) {
    $severityMarker = [regex]::Escape($severity + ':')
    if ($policy -notmatch $severityMarker) {
        throw "Drift policy missing severity level: $severity"
    }
}

$reportTemplate = Get-Content (Join-Path $RepoRoot 'reports/templates/ORCHESTRATOR_DRIFT_VALIDATION_REPORT_TEMPLATE.md') -Raw
foreach ($field in @('repository', 'releaseTrain', 'validationTimestampUtc', 'commitShaOrRef', 'checksRun', 'findingsBySeverity', 'globalWriteGates', 'passFailStatus', 'nextActions')) {
    $escapedField = [regex]::Escape($field)
    if ($policy -notmatch $escapedField -and $reportTemplate -notmatch $escapedField) {
        throw "Required report field not represented: $field"
    }
}

Write-Host 'PASSED: O-RT4 drift harness baseline verified.'
