# Test-OrchestratorLocalClientEvidencePack.ps1
# O-RT11 local MCP client evidence pack validation.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/ORT11_LOCAL_MCP_CLIENT_EVIDENCE_PACK_20260705.md',
    'config/local-mcp-client-evidence.yml',
    'templates/local-mcp-client/LOCAL_MCP_CLIENT_SANITIZATION_TEMPLATE.md',
    'examples/local-mcp-client/claude_desktop_sanitized_example.json',
    'examples/local-mcp-client/cursor_sanitized_example.json'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing O-RT11 required file: $file"
    }
}

$config = Get-Content (Join-Path $RepoRoot 'config/local-mcp-client-evidence.yml') -Raw
foreach ($marker in @(
    'release_train: O-RT11',
    'mode: LOCAL_CLIENT_EVIDENCE_PACK',
    'status: pending_evidence',
    'live_write_approved: false',
    'secret_capture_allowed: false',
    'claude-desktop-local-mcp',
    'cursor-local-mcp',
    'current_status: NOT_CONFIGURED',
    'evidence_status: pending_evidence'
)) {
    if ($config -notmatch [regex]::Escape($marker)) {
        throw "Local MCP client evidence config missing marker: $marker"
    }
}

foreach ($sample in @(
    'examples/local-mcp-client/claude_desktop_sanitized_example.json',
    'examples/local-mcp-client/cursor_sanitized_example.json'
)) {
    $samplePath = Join-Path $RepoRoot $sample
    $evidence = Get-Content $samplePath -Raw | ConvertFrom-Json
    if ($evidence.sanitizationConfirmed -ne $true) {
        throw "Sample evidence does not confirm sanitization: $sample"
    }
    if ($evidence.secretsIncluded -ne $false) {
        throw "Sample evidence allows protected values: $sample"
    }
}

Write-Host 'PASSED: O-RT11 local MCP client evidence pack verified as pending evidence.'
