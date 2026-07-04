# Test-OrchestratorChangePackSchema.ps1
# O-RT5 change-pack schema and sample validation without external modules.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$schemaPath = Join-Path $RepoRoot 'schemas/change-pack.schema.json'
$samplePath = Join-Path $RepoRoot 'examples/change-packs/sample_pr_first_change_pack.json'

foreach ($path in @($schemaPath, $samplePath)) {
    if (-not (Test-Path $path)) {
        throw "Missing required O-RT5 file: $path"
    }
}

$schema = Get-Content $schemaPath -Raw | ConvertFrom-Json
$sample = Get-Content $samplePath -Raw | ConvertFrom-Json

if ($schema.properties.mode.const -ne 'PR_FIRST_CONTROLLED_CHANGE') {
    throw 'Change-pack schema does not require PR_FIRST_CONTROLLED_CHANGE mode.'
}

if ($schema.properties.executionAllowed.const -ne $false) {
    throw 'Change-pack schema does not require executionAllowed false.'
}

$requiredTopLevel = @(
    'changeId',
    'releaseTrain',
    'mode',
    'executionAllowed',
    'sourcePlan',
    'targetRepository',
    'targetBranchStrategy',
    'filesToChange',
    'actionClass',
    'approvalRequired',
    'validationRequired',
    'rollbackPlan',
    'deploymentImpact',
    'blockedActions',
    'auditOutputs'
)

foreach ($field in $requiredTopLevel) {
    if (-not ($schema.required -contains $field)) {
        throw "Schema missing required field: $field"
    }
    if (-not ($sample.PSObject.Properties.Name -contains $field)) {
        throw "Sample change pack missing field: $field"
    }
}

if ($sample.releaseTrain -ne 'O-RT5') {
    throw "Sample change pack releaseTrain must be O-RT5. Actual: $($sample.releaseTrain)"
}

if ($sample.mode -ne 'PR_FIRST_CONTROLLED_CHANGE') {
    throw "Sample change pack mode must be PR_FIRST_CONTROLLED_CHANGE. Actual: $($sample.mode)"
}

if ($sample.executionAllowed -ne $false) {
    throw 'Sample change pack executionAllowed must be false.'
}

if ($sample.approvalRequired -ne $true) {
    throw 'Sample change pack approvalRequired must be true.'
}

if ($sample.targetBranchStrategy.directMainWriteAllowed -ne $false) {
    throw 'Sample change pack directMainWriteAllowed must be false.'
}

foreach ($blocked in @('AUTO_MERGE', 'AUTO_DEPLOY', 'PRODUCTION_DEPLOYMENT', 'DESTRUCTIVE_OPERATION')) {
    if ($sample.blockedActions -notcontains $blocked) {
        throw "Sample change pack missing blocked action: $blocked"
    }
}

Write-Host 'PASSED: O-RT5 change-pack schema and sample verified.'
