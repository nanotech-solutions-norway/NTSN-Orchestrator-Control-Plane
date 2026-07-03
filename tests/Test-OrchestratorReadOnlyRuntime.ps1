# Test-OrchestratorReadOnlyRuntime.ps1
# O-RT2 read-only route contract test.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/ORT2_READONLY_CONTROL_PLANE_RUNTIME_20260703.md',
    'config/read-only-routes.yml',
    'openapi/orchestrator-readonly.openapi.json',
    'config/evidence-status.yml',
    'config/orchestrator-registry.json',
    'config/action-classification.yml',
    'config/provider-boundary.yml'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing required O-RT2 read-only runtime file: $file"
    }
}

$routeMap = Get-Content (Join-Path $RepoRoot 'config/read-only-routes.yml') -Raw

foreach ($marker in @(
    'runtime_contract: GET_ONLY',
    'live_write_approved: false',
    'unknown_action_default: NOT_CONFIGURED',
    'conflict_default: PENDING_REVIEW'
)) {
    if ($routeMap -notmatch [regex]::Escape($marker)) {
        throw "Route map missing required marker: $marker"
    }
}

foreach ($blockedMethod in @('POST', 'PUT', 'PATCH', 'DELETE')) {
    if ($routeMap -notmatch "- $blockedMethod") {
        throw "Route map missing blocked method: $blockedMethod"
    }
}

if ($routeMap -match 'method:\s*(POST|PUT|PATCH|DELETE)') {
    throw 'Route map exposes a non-GET method.'
}

$runtimeDoc = Get-Content (Join-Path $RepoRoot 'docs/ORT2_READONLY_CONTROL_PLANE_RUNTIME_20260703.md') -Raw
foreach ($marker in @(
    'GET_ONLY_RUNTIME_CONTRACT',
    'POST',
    'PUT',
    'PATCH',
    'DELETE',
    'NOT_CONFIGURED',
    'PENDING_REVIEW'
)) {
    if ($runtimeDoc -notmatch [regex]::Escape($marker)) {
        throw "Runtime doc missing marker: $marker"
    }
}

Write-Host 'PASSED: O-RT2 read-only runtime route contract verified.'
