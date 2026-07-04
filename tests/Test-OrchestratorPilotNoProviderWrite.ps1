# Test-OrchestratorPilotNoProviderWrite.ps1
# O-RT7 pilot no-provider-write validation.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$policyPath = Join-Path $RepoRoot 'config/operations-pilot.yml'
$evidenceStatusPath = Join-Path $RepoRoot 'config/evidence-status.yml'
$samples = @(
    'examples/operations-pilot/sample_readonly_aggregation_pilot.json',
    'examples/operations-pilot/sample_draft_change_pack_pilot.json'
)

foreach ($path in @($policyPath, $evidenceStatusPath)) {
    if (-not (Test-Path $path)) {
        throw "Missing required O-RT7 no-write input: $path"
    }
}

$policy = Get-Content $policyPath -Raw
$evidence = Get-Content $evidenceStatusPath -Raw

foreach ($marker in @(
    'provider_write_allowed: false',
    'production_write_allowed: false',
    'auto_merge_allowed: false',
    'auto_deploy_allowed: false',
    'secret_readout_allowed: false'
)) {
    if ($policy -notmatch [regex]::Escape($marker)) {
        throw "Operations pilot policy missing no-write marker: $marker"
    }
}

foreach ($marker in @(
    'live_provider_write_approved: false',
    'dns_write_approved: false',
    'production_deployment_approved: false',
    'destructive_operations_approved: false'
)) {
    if ($evidence -notmatch [regex]::Escape($marker)) {
        throw "Evidence status missing global gate marker: $marker"
    }
}

foreach ($sample in $samples) {
    $samplePath = Join-Path $RepoRoot $sample
    if (-not (Test-Path $samplePath)) {
        throw "Missing sample pilot: $sample"
    }
    $pilot = Get-Content $samplePath -Raw | ConvertFrom-Json

    if ($pilot.executionAllowed -ne $false) {
        throw "Pilot sample allows execution: $sample"
    }
    foreach ($gate in @('liveProviderWriteApproved', 'dnsWriteApproved', 'productionDeploymentApproved', 'destructiveOperationsApproved')) {
        if ($pilot.globalWriteGates.$gate -ne $false) {
            throw "Pilot sample write gate $gate is not false: $sample"
        }
    }
    foreach ($blocked in @('provider_state_change', 'production_deployment', 'secret_value_export')) {
        if ($pilot.blockedActions -notcontains $blocked) {
            throw "Pilot sample missing blocked action $blocked: $sample"
        }
    }
}

Write-Host 'PASSED: O-RT7 pilot no-provider-write controls verified.'
