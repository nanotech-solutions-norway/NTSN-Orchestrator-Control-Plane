# Test-OrchestratorNoWriteExposure.ps1
# O-RT1 no-write exposure test.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$filesToCheck = @(
    'config/evidence-status.yml',
    'config/orchestrator-registry.json',
    'config/action-classification.yml',
    'config/provider-boundary.yml',
    'docs/ORCHESTRATOR_REGISTRY.md'
)

foreach ($file in $filesToCheck) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing required no-write validation file: $file"
    }
}

$evidence = Get-Content (Join-Path $RepoRoot 'config/evidence-status.yml') -Raw
foreach ($marker in @(
    'live_provider_write_approved: false',
    'dns_write_approved: false',
    'production_deployment_approved: false',
    'destructive_operations_approved: false'
)) {
    if ($evidence -notmatch [regex]::Escape($marker)) {
        throw "Missing required no-write marker: $marker"
    }
}

$registryText = Get-Content (Join-Path $RepoRoot 'docs/ORCHESTRATOR_REGISTRY.md') -Raw
foreach ($marker in @(
    'LIVE_WRITE_NOT_APPROVED',
    'DNS writes',
    'FTP/SFTP writes',
    'SQL writes',
    'Production deployment',
    'Destructive operations'
)) {
    if ($registryText -notmatch [regex]::Escape($marker)) {
        throw "Registry missing expected no-write marker: $marker"
    }
}

$classification = Get-Content (Join-Path $RepoRoot 'config/action-classification.yml') -Raw
foreach ($blocked in @(
    'DNS_WRITE',
    'FTP_SFTP_WRITE',
    'SQL_WRITE',
    'ACCOUNTING_WRITE_OR_SUBMISSION',
    'PRODUCTION_DEPLOYMENT',
    'DESTRUCTIVE_OPERATION'
)) {
    if ($classification -notmatch [regex]::Escape($blocked)) {
        throw "Action classification missing blocked action: $blocked"
    }
}

$providerBoundary = Get-Content (Join-Path $RepoRoot 'config/provider-boundary.yml') -Raw
if ($providerBoundary -notmatch 'live_provider_write_approved: false') {
    throw 'Provider boundary does not preserve live_provider_write_approved: false.'
}

Write-Host 'PASSED: O-RT1 no-write exposure controls verified.'
