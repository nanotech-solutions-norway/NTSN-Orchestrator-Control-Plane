# Test-OrchestratorMcpRuntimeClientRefresh.ps1
# O-RT8 MCP runtime/client config refresh validation.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/evidence/MCP_RUNTIME_CLIENT_CONFIG_EVIDENCE_INTAKE_1233_04072026.md',
    'docs/ORT8_MCP_RUNTIME_CLIENT_CONFIG_REFRESH_20260704.md',
    'config/mcp-runtime-client-alignment.yml'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing O-RT8 required file: $file"
    }
}

$alignment = Get-Content (Join-Path $RepoRoot 'config/mcp-runtime-client-alignment.yml') -Raw
foreach ($marker in @(
    'release_train: O-RT8',
    'status: evidence_refresh',
    'live_http_check_performed_in_package: false',
    'live_write_approved: false',
    'READ_ONLY_READY',
    'PLAN_ONLY_READY',
    'CONTROLLED_WRITE_PENDING_APPROVAL',
    'NOT_CONFIGURED'
)) {
    if ($alignment -notmatch [regex]::Escape($marker)) {
        throw "MCP runtime/client alignment missing marker: $marker"
    }
}

foreach ($client in @(
    'conta-mcp',
    'domeneshop-mcp-public-health',
    'domeneshop-mcp-status',
    'ntsn-orchestrator-control-plane',
    'powershell-control-plane',
    'python-control-plane',
    'github-connector',
    'wix-connector',
    'ai-memory-ops',
    'claude-desktop-local-mcp',
    'cursor-local-mcp'
)) {
    if ($alignment -notmatch [regex]::Escape($client)) {
        throw "MCP runtime/client alignment missing client entry: $client"
    }
}

$intake = Get-Content (Join-Path $RepoRoot 'docs/evidence/MCP_RUNTIME_CLIENT_CONFIG_EVIDENCE_INTAKE_1233_04072026.md') -Raw
foreach ($marker in @(
    'MCP_RUNTIME_CLIENT_CONFIG_EVIDENCE_INDEXED',
    'RAW_CREDENTIAL_VALUES_NOT_DETECTED_BY_PATTERN_SCAN',
    'LIVE_HTTP_CHECK_NOT_PERFORMED_IN_PACKAGE',
    'NO_LIVE_WRITE_APPROVAL'
)) {
    if ($intake -notmatch [regex]::Escape($marker)) {
        throw "MCP evidence intake missing marker: $marker"
    }
}

Write-Host 'PASSED: O-RT8 MCP runtime/client config refresh verified.'
