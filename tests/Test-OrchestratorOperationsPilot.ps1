# Test-OrchestratorOperationsPilot.ps1
# O-RT7 operations pilot contract validation.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/ORT7_APPROVAL_GATED_OPERATIONS_PILOT_20260703.md',
    'config/operations-pilot.yml',
    'schemas/operations-pilot.schema.json',
    'templates/operations-pilot/OPERATIONS_PILOT_RUNBOOK_TEMPLATE.md',
    'examples/operations-pilot/sample_readonly_aggregation_pilot.json',
    'examples/operations-pilot/sample_draft_change_pack_pilot.json'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing O-RT7 required file: $file"
    }
}

$policy = Get-Content (Join-Path $RepoRoot 'config/operations-pilot.yml') -Raw
foreach ($marker in @(
    'mode: APPROVAL_GATED_OPERATIONS_PILOT',
    'execution_allowed: false',
    'live_write_approved: false',
    'provider_write_allowed: false',
    'production_write_allowed: false',
    'unknown_pilot_action_default: NOT_CONFIGURED',
    'conflict_default: PENDING_REVIEW'
)) {
    if ($policy -notmatch [regex]::Escape($marker)) {
        throw "Operations pilot policy missing marker: $marker"
    }
}

foreach ($operation in @('read_only_aggregation', 'evidence_pack_generation', 'draft_change_pack_generation')) {
    if ($policy -notmatch [regex]::Escape($operation)) {
        throw "Operations pilot policy missing allowed operation: $operation"
    }
}

$schema = Get-Content (Join-Path $RepoRoot 'schemas/operations-pilot.schema.json') -Raw | ConvertFrom-Json
if ($schema.properties.releaseTrain.const -ne 'O-RT7') {
    throw 'Operations pilot schema does not require releaseTrain O-RT7.'
}
if ($schema.properties.mode.const -ne 'APPROVAL_GATED_OPERATIONS_PILOT') {
    throw 'Operations pilot schema does not require APPROVAL_GATED_OPERATIONS_PILOT mode.'
}
if ($schema.properties.operatorApprovalRequired.const -ne $true) {
    throw 'Operations pilot schema does not require operatorApprovalRequired true.'
}
if ($schema.properties.executionAllowed.const -ne $false) {
    throw 'Operations pilot schema does not require executionAllowed false.'
}

foreach ($sample in @(
    'examples/operations-pilot/sample_readonly_aggregation_pilot.json',
    'examples/operations-pilot/sample_draft_change_pack_pilot.json'
)) {
    $samplePlan = Get-Content (Join-Path $RepoRoot $sample) -Raw | ConvertFrom-Json
    if ($samplePlan.releaseTrain -ne 'O-RT7') { throw "Sample $sample has wrong releaseTrain." }
    if ($samplePlan.mode -ne 'APPROVAL_GATED_OPERATIONS_PILOT') { throw "Sample $sample has wrong mode." }
    if ($samplePlan.operatorApprovalRequired -ne $true) { throw "Sample $sample requires no operator approval." }
    if ($samplePlan.executionAllowed -ne $false) { throw "Sample $sample allows execution." }
}

Write-Host 'PASSED: O-RT7 operations pilot contract verified.'
