# Test-OrchestratorProviderBoundaryDrift.ps1
# O-RT4 provider boundary drift test.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$providerBoundaryPath = Join-Path $RepoRoot 'config/provider-boundary.yml'
$actionClassificationPath = Join-Path $RepoRoot 'config/action-classification.yml'

foreach ($path in @($providerBoundaryPath, $actionClassificationPath)) {
    if (-not (Test-Path $path)) {
        throw "Missing provider boundary drift input: $path"
    }
}

$providerBoundary = Get-Content $providerBoundaryPath -Raw
$actionClassification = Get-Content $actionClassificationPath -Raw

foreach ($marker in @(
    'live_provider_write_approved: false',
    'write_status:',
    'blocked_without_approval:',
    'unknown_provider_action: NOT_CONFIGURED'
)) {
    if ($providerBoundary -notmatch [regex]::Escape($marker)) {
        throw "Provider boundary missing required marker: $marker"
    }
}

foreach ($provider in @('github', 'wix', 'domeneshop', 'conta', 'powershell', 'python', 'custom_gpt', 'memory_ops')) {
    if ($providerBoundary -notmatch "(?m)^\s{2}$provider:") {
        throw "Provider boundary missing provider: $provider"
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
        throw "Action classification missing blocked action: $blocked"
    }
}

if ($providerBoundary -match 'live_provider_write_approved:\s*true') {
    throw 'Provider boundary drift detected: live_provider_write_approved true.'
}

Write-Host 'PASSED: O-RT4 provider boundary drift check passed.'
