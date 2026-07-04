# Test-OrchestratorAdapterNoBypass.ps1
# O-RT6 adapter no-bypass validation.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$adapterRegistryPath = Join-Path $RepoRoot 'config/provider-adapters.yml'
$providerBoundaryPath = Join-Path $RepoRoot 'config/provider-boundary.yml'
$actionClassificationPath = Join-Path $RepoRoot 'config/action-classification.yml'
$sampleAdapterPath = Join-Path $RepoRoot 'examples/provider-adapters/sample_readonly_provider_adapter.json'

foreach ($path in @($adapterRegistryPath, $providerBoundaryPath, $actionClassificationPath, $sampleAdapterPath)) {
    if (-not (Test-Path $path)) {
        throw "Missing no-bypass validation input: $path"
    }
}

$adapterRegistry = Get-Content $adapterRegistryPath -Raw
$providerBoundary = Get-Content $providerBoundaryPath -Raw
$actionClassification = Get-Content $actionClassificationPath -Raw
$sampleAdapter = Get-Content $sampleAdapterPath -Raw | ConvertFrom-Json

if ($adapterRegistry -match 'adapter_bypass_allowed:\s*true') {
    throw 'Adapter registry drift: adapter_bypass_allowed is true.'
}

if ($adapterRegistry -match 'live_write_approved:\s*true') {
    throw 'Adapter registry drift: live_write_approved is true.'
}

if ($providerBoundary -match 'live_provider_write_approved:\s*true') {
    throw 'Provider boundary drift: live_provider_write_approved is true.'
}

foreach ($marker in @(
    'unknown_adapter_action_default: NOT_CONFIGURED',
    'fallbackOnUnknown: NOT_CONFIGURED',
    'fallbackOnUnknown: PENDING_REVIEW',
    'approvalRequiredForWrite: true',
    'auditRequired: true'
)) {
    if ($adapterRegistry -notmatch [regex]::Escape($marker)) {
        throw "Adapter registry missing no-bypass marker: $marker"
    }
}

foreach ($blocked in @(
    'DNS_WRITE',
    'FTP_SFTP_WRITE',
    'SQL_WRITE',
    'ACCOUNTING_WRITE_OR_SUBMISSION',
    'PRODUCTION_DEPLOYMENT',
    'DESTRUCTIVE_OPERATION'
)) {
    if ($actionClassification -notmatch [regex]::Escape($blocked)) {
        throw "Action classification missing blocked class: $blocked"
    }
}

if ($sampleAdapter.executionAllowedByDefault -ne $false) {
    throw 'Sample adapter executionAllowedByDefault must be false.'
}

if ($sampleAdapter.approvalRequiredForWrite -ne $true) {
    throw 'Sample adapter approvalRequiredForWrite must be true.'
}

if ($sampleAdapter.auditRequired -ne $true) {
    throw 'Sample adapter auditRequired must be true.'
}

if ($sampleAdapter.fallbackOnUnknown -ne 'NOT_CONFIGURED') {
    throw 'Sample adapter fallbackOnUnknown must be NOT_CONFIGURED.'
}

Write-Host 'PASSED: O-RT6 adapter no-bypass controls verified.'
