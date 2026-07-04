# Test-OrchestratorPlanSchema.ps1
# O-RT3 plan artifact structural validation without external modules.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$schemaPath = Join-Path $RepoRoot 'schemas/orchestrator-plan.schema.json'
$planPath = Join-Path $RepoRoot 'examples/plan-only/sample_provider_change_plan.json'

foreach ($path in @($schemaPath, $planPath)) {
    if (-not (Test-Path $path)) {
        throw "Missing required file: $path"
    }
}

$schema = Get-Content $schemaPath -Raw | ConvertFrom-Json
$plan = Get-Content $planPath -Raw | ConvertFrom-Json

if ($schema.title -notmatch 'Plan-only') {
    throw 'Plan schema title does not indicate plan-only usage.'
}

if ($schema.properties.mode.const -ne 'PLAN_ONLY') {
    throw 'Plan schema does not require mode PLAN_ONLY.'
}

if ($schema.properties.executionAllowed.const -ne $false) {
    throw 'Plan schema does not require executionAllowed false.'
}

$requiredTopLevel = @(
    'planId',
    'releaseTrain',
    'mode',
    'executionAllowed',
    'requestedObjective',
    'sourceEvidence',
    'globalWriteGates',
    'steps',
    'rollbackPlan',
    'validationPlan',
    'auditOutputs'
)

foreach ($field in $requiredTopLevel) {
    if (-not ($schema.required -contains $field)) {
        throw "Schema missing required top-level field: $field"
    }
    if (-not ($plan.PSObject.Properties.Name -contains $field)) {
        throw "Sample plan missing required top-level field: $field"
    }
}

if ($plan.releaseTrain -ne 'O-RT3') {
    throw "Sample plan releaseTrain must be O-RT3. Actual: $($plan.releaseTrain)"
}

if ($plan.mode -ne 'PLAN_ONLY') {
    throw "Sample plan mode must be PLAN_ONLY. Actual: $($plan.mode)"
}

if ($plan.executionAllowed -ne $false) {
    throw 'Sample plan executionAllowed must be false.'
}

foreach ($step in $plan.steps) {
    foreach ($field in @('stepId', 'title', 'targetSystem', 'targetMcpOrProvider', 'actionClass', 'planAction', 'executionAllowed', 'approvalRequired', 'evidenceRequired', 'payloadShape', 'validation')) {
        if (-not ($step.PSObject.Properties.Name -contains $field)) {
            throw "Sample plan step $($step.stepId) missing required field: $field"
        }
    }

    if ($step.executionAllowed -ne $false) {
        throw "Sample plan step $($step.stepId) allows execution."
    }
}

Write-Host 'PASSED: O-RT3 plan schema and sample plan structure verified.'
