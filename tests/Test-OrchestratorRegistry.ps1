# Test-OrchestratorRegistry.ps1
# O-RT1 canonical registry integrity test.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/ORCHESTRATOR_REGISTRY.md',
    'config/orchestrator-registry.json',
    'docs/PENDING_REVIEW_ITEMS_ORT1_20260703.md',
    'docs/CONFLICT_POLICY_ORT1_20260703.md',
    'config/action-classification.yml',
    'config/provider-boundary.yml',
    'config/evidence-status.yml'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing required O-RT1 registry file: $file"
    }
}

$registryJsonPath = Join-Path $RepoRoot 'config/orchestrator-registry.json'
$registry = Get-Content $registryJsonPath -Raw | ConvertFrom-Json

if ($registry.releaseTrain -ne 'O-RT1') {
    throw "Registry releaseTrain is not O-RT1. Actual: $($registry.releaseTrain)"
}

if ($registry.classification.liveWriteApproved -ne $false) {
    throw 'Registry incorrectly marks liveWriteApproved as true.'
}

if ($registry.globalControlStatus.liveProviderWriteApproved -ne $false) {
    throw 'liveProviderWriteApproved must remain false.'
}

if ($registry.globalControlStatus.dnsWriteApproved -ne $false) {
    throw 'dnsWriteApproved must remain false.'
}

if ($registry.globalControlStatus.productionDeploymentApproved -ne $false) {
    throw 'productionDeploymentApproved must remain false.'
}

if ($registry.globalControlStatus.destructiveOperationsApproved -ne $false) {
    throw 'destructiveOperationsApproved must remain false.'
}

if ($registry.runtimeClasses -contains 'LIVE_WRITE_APPROVED') {
    throw 'LIVE_WRITE_APPROVED must not be present in O-RT1 runtimeClasses.'
}

$pendingPath = Join-Path $RepoRoot 'docs/PENDING_REVIEW_ITEMS_ORT1_20260703.md'
$pending = Get-Content $pendingPath -Raw
if ($pending -notmatch 'PENDING_REVIEW != APPROVED') {
    throw 'Pending-review register does not contain required non-approval marker.'
}

$conflictPath = Join-Path $RepoRoot 'docs/CONFLICT_POLICY_ORT1_20260703.md'
$conflict = Get-Content $conflictPath -Raw
if ($conflict -notmatch 'CONFLICTS BECOME PENDING_REVIEW') {
    throw 'Conflict policy does not enforce PENDING_REVIEW conflict handling.'
}

Write-Host 'PASSED: O-RT1 orchestrator registry integrity verified.'
