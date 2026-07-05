# Test-OrchestratorValidationSuite.ps1
# Deterministic validation suite runner for O-RT1 through O-RT10.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [string]$ReportPath = (Join-Path (Join-Path (Resolve-Path (Join-Path $PSScriptRoot '..')).Path 'artifacts') 'orchestrator-drift-validation-report.md')
)

$ErrorActionPreference = 'Stop'

$tests = @(
    'Test-OrchestratorRegistry.ps1',
    'Test-OrchestratorNoWriteExposure.ps1',
    'Test-OrchestratorReadOnlyRuntime.ps1',
    'Test-OrchestratorOpenApiGetOnly.ps1',
    'Test-PlanOnlyPolicyEngine.ps1',
    'Test-OrchestratorPlanSchema.ps1',
    'Test-OrchestratorDriftHarness.ps1',
    'Test-OrchestratorRouteOpenApiDrift.ps1',
    'Test-OrchestratorProviderBoundaryDrift.ps1',
    'Test-OrchestratorPrFirstChangePath.ps1',
    'Test-OrchestratorChangePackSchema.ps1',
    'Test-OrchestratorProviderAdapterContracts.ps1',
    'Test-OrchestratorAdapterNoBypass.ps1',
    'Test-OrchestratorOperationsPilot.ps1',
    'Test-OrchestratorPilotNoProviderWrite.ps1',
    'Test-OrchestratorMcpRuntimeClientRefresh.ps1',
    'Test-OrchestratorProtectedEndpointValidationPlan.ps1',
    'Test-OrchestratorRuntimeReadinessReportPack.ps1'
)

$results = @()
foreach ($test in $tests) {
    $testPath = Join-Path $PSScriptRoot $test
    if (-not (Test-Path $testPath)) {
        throw "Missing validation test: $test"
    }

    try {
        & $testPath -RepoRoot $RepoRoot | Out-String | Write-Verbose
        $results += [pscustomobject]@{
            Test = $test
            Status = 'PASS'
            Severity = 'INFO'
            Finding = 'None'
        }
    }
    catch {
        $results += [pscustomobject]@{
            Test = $test
            Status = 'FAIL'
            Severity = 'HIGH'
            Finding = $_.Exception.Message
        }
    }
}

$failed = $results | Where-Object { $_.Status -eq 'FAIL' }

$artifactDir = Split-Path -Parent $ReportPath
if (-not (Test-Path $artifactDir)) {
    New-Item -ItemType Directory -Force -Path $artifactDir | Out-Null
}

$timestamp = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
$status = if ($failed.Count -eq 0) { 'VALIDATION_PASSED' } else { 'VALIDATION_FAILED' }

$reportLines = @()
$reportLines += '# Orchestrator Drift Validation Report'
$reportLines += ''
$reportLines += '## Metadata'
$reportLines += ''
$reportLines += '| Field | Value |'
$reportLines += '|---|---|'
$reportLines += "| Repository | nanotech-solutions-norway/NTSN-Orchestrator-Control-Plane |"
$reportLines += "| Release train coverage | O-RT1 through O-RT10 |"
$reportLines += "| Validation timestamp UTC | $timestamp |"
$reportLines += "| Commit SHA/ref | `${env:GITHUB_SHA} |"
$reportLines += "| Validation mode | VALIDATION_ONLY |"
$reportLines += "| Execution allowed | false |"
$reportLines += ''
$reportLines += '## Global write gates'
$reportLines += ''
$reportLines += '```text'
$reportLines += 'live_provider_write_approved: false'
$reportLines += 'dns_write_approved: false'
$reportLines += 'production_deployment_approved: false'
$reportLines += 'destructive_operations_approved: false'
$reportLines += '```'
$reportLines += ''
$reportLines += '## Checks run'
$reportLines += ''
$reportLines += '| Check | Status | Severity | Finding |'
$reportLines += '|---|---|---|---|'
foreach ($result in $results) {
    $safeFinding = ($result.Finding -replace '\|', '/')
    $reportLines += "| $($result.Test) | $($result.Status) | $($result.Severity) | $safeFinding |"
}
$reportLines += ''
$reportLines += '## Pass/fail status'
$reportLines += ''
$reportLines += '```text'
$reportLines += $status
$reportLines += '```'
$reportLines += ''
$reportLines += '## Boundary confirmation'
$reportLines += ''
$reportLines += '```text'
$reportLines += 'NO_PROVIDER_MUTATION'
$reportLines += 'NO_WORKFLOW_WRITE_DISPATCH'
$reportLines += 'NO_DNS_WRITE'
$reportLines += 'NO_FTP_SFTP_WRITE'
$reportLines += 'NO_SQL_WRITE'
$reportLines += 'NO_ACCOUNTING_WRITE'
$reportLines += 'NO_PRODUCTION_DEPLOYMENT'
$reportLines += 'NO_DESTRUCTIVE_OPERATION'
$reportLines += 'NO_DIRECT_PROVIDER_PUBLISH'
$reportLines += 'NO_SECRET_VALUE_READOUT'
$reportLines += '```'

$reportLines | Set-Content -Path $ReportPath -Encoding UTF8

if ($failed.Count -gt 0) {
    throw "Orchestrator validation failed. See report: $ReportPath"
}

Write-Host "PASSED: Orchestrator validation suite passed for O-RT1 through O-RT10. Report: $ReportPath"
