# Test-OrchestratorProtectedEndpointValidationPlan.ps1
# O-RT9 protected endpoint validation planning test.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/ORT9_PROTECTED_ENDPOINT_VALIDATION_PLANNING_20260704.md',
    'config/protected-endpoint-validation.yml',
    'templates/protected-endpoint-validation/PROTECTED_ENDPOINT_VALIDATION_RUNBOOK_TEMPLATE.md'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing O-RT9 required file: $file"
    }
}

$policy = Get-Content (Join-Path $RepoRoot 'config/protected-endpoint-validation.yml') -Raw
foreach ($marker in @(
    'release_train: O-RT9',
    'mode: PROTECTED_ENDPOINT_VALIDATION_PLANNING',
    'execution_allowed: false',
    'live_write_approved: false',
    'secret_capture_allowed: false',
    'repository_secret_storage_allowed: false',
    'chat_secret_entry_allowed: false',
    'unknown_validation_default: NOT_CONFIGURED',
    'failed_or_incomplete_validation_default: PENDING_REVIEW'
)) {
    if ($policy -notmatch [regex]::Escape($marker)) {
        throw "Protected endpoint validation policy missing marker: $marker"
    }
}

foreach ($surface in @(
    'domeneshop-mcp-public-health',
    'domeneshop-mcp-status',
    'conta-mcp',
    'ntsn-orchestrator-control-plane',
    'powershell-control-plane',
    'python-control-plane',
    'github-connector',
    'wix-connector',
    'ai-memory-ops'
)) {
    if ($policy -notmatch [regex]::Escape($surface)) {
        throw "Protected endpoint validation policy missing surface: $surface"
    }
}

foreach ($forbidden in @(
    'protected_values',
    'raw_headers',
    'full_env_values',
    'private_payloads',
    'provider_mutation_payloads'
)) {
    if ($policy -notmatch [regex]::Escape($forbidden)) {
        throw "Protected endpoint validation policy missing forbidden output: $forbidden"
    }
}

Write-Host 'PASSED: O-RT9 protected endpoint validation plan verified.'
