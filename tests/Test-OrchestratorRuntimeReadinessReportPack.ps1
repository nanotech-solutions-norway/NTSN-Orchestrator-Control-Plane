# Test-OrchestratorRuntimeReadinessReportPack.ps1
# O-RT10 runtime readiness report pack validation.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/ORT10_RUNTIME_READINESS_REPORT_PACK_20260704.md',
    'config/runtime-readiness-report-pack.yml',
    'reports/runtime-readiness/ORCHESTRATOR_RUNTIME_READINESS_REPORT_20260704.md'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing O-RT10 required file: $file"
    }
}

$config = Get-Content (Join-Path $RepoRoot 'config/runtime-readiness-report-pack.yml') -Raw
foreach ($marker in @(
    'release_train: O-RT10',
    'mode: RUNTIME_READINESS_REPORT_PACK',
    'report_only: true',
    'execution_allowed: false',
    'live_write_approved: false',
    'endpoint_calls_allowed: false',
    'secret_handling_allowed: false'
)) {
    if ($config -notmatch [regex]::Escape($marker)) {
        throw "Runtime readiness report pack config missing marker: $marker"
    }
}

foreach ($phase in @('O-RT1','O-RT2','O-RT3','O-RT4','O-RT5','O-RT6','O-RT7','O-RT8','O-RT9')) {
    if ($config -notmatch [regex]::Escape($phase)) {
        throw "Runtime readiness report pack config missing phase: $phase"
    }
}

$report = Get-Content (Join-Path $RepoRoot 'reports/runtime-readiness/ORCHESTRATOR_RUNTIME_READINESS_REPORT_20260704.md') -Raw
foreach ($marker in @(
    'READINESS_REPORT_COMPLETE',
    'REPORT_ONLY_READY',
    'LIVE_WRITE_NOT_APPROVED',
    'Remaining gaps before a future controlled live-operation proposal',
    'live_provider_write_approved: false',
    'dns_write_approved: false',
    'production_deployment_approved: false',
    'destructive_operations_approved: false'
)) {
    if ($report -notmatch [regex]::Escape($marker)) {
        throw "Runtime readiness report missing marker: $marker"
    }
}

Write-Host 'PASSED: O-RT10 runtime readiness report pack verified.'
