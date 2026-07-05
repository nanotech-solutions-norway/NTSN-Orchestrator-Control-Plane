# Test-OrchestratorProviderAdapterContracts.ps1
# O-RT6 provider adapter contract completeness test.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/ORT6_PROVIDER_ADAPTER_CONTROL_LAYER_20260703.md',
    'config/provider-adapters.yml',
    'schemas/provider-adapter.schema.json',
    'templates/provider-adapter/PROVIDER_ADAPTER_CONTRACT_TEMPLATE.md',
    'examples/provider-adapters/sample_readonly_provider_adapter.json'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing O-RT6 required file: $file"
    }
}

$registry = Get-Content (Join-Path $RepoRoot 'config/provider-adapters.yml') -Raw
foreach ($marker in @(
    'mode: PROVIDER_ADAPTER_CONTRACT',
    'live_write_approved: false',
    'adapter_bypass_allowed: false',
    'unknown_adapter_action_default: NOT_CONFIGURED',
    'conflict_default: PENDING_REVIEW'
)) {
    if ($registry -notmatch [regex]::Escape($marker)) {
        throw "Provider adapter registry missing marker: $marker"
    }
}

foreach ($adapter in @('github', 'wix', 'domeneshop', 'conta', 'powershell', 'python', 'custom_gpt', 'memory_ops')) {
    $adapterPattern = '(?m)^\s{2}' + [regex]::Escape($adapter + ':')
    if ($registry -notmatch $adapterPattern) {
        throw "Provider adapter registry missing adapter: $adapter"
    }
}

foreach ($requiredField in @(
    'adapterId:',
    'provider:',
    'runtimeClass:',
    'readCapabilities:',
    'planCapabilities:',
    'writeCapabilities:',
    'approvalRequiredForWrite:',
    'dryRunSupported:',
    'auditRequired:',
    'forbiddenActionCategories:',
    'evidenceSources:',
    'fallbackOnUnknown:'
)) {
    if ($registry -notmatch [regex]::Escape($requiredField)) {
        throw "Provider adapter registry missing field marker: $requiredField"
    }
}

$schema = Get-Content (Join-Path $RepoRoot 'schemas/provider-adapter.schema.json') -Raw | ConvertFrom-Json
if ($schema.properties.releaseTrain.const -ne 'O-RT6') {
    throw 'Provider adapter schema does not require releaseTrain O-RT6.'
}
if ($schema.properties.approvalRequiredForWrite.const -ne $true) {
    throw 'Provider adapter schema does not require approvalRequiredForWrite true.'
}
if ($schema.properties.auditRequired.const -ne $true) {
    throw 'Provider adapter schema does not require auditRequired true.'
}
if ($schema.properties.executionAllowedByDefault.const -ne $false) {
    throw 'Provider adapter schema does not require executionAllowedByDefault false.'
}

Write-Host 'PASSED: O-RT6 provider adapter contracts verified.'
