# Test-PlanOnlyPolicyEngine.ps1
# O-RT3 plan-only policy validation.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/ORT3_PLAN_ONLY_ORCHESTRATION_ENGINE_20260703.md',
    'config/plan-only-policy.yml',
    'schemas/orchestrator-plan.schema.json',
    'examples/plan-only/sample_provider_change_plan.json'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing O-RT3 required file: $file"
    }
}

$policy = Get-Content (Join-Path $RepoRoot 'config/plan-only-policy.yml') -Raw
foreach ($marker in @(
    'mode: PLAN_ONLY',
    'execution_allowed: false',
    'live_write_approved: false',
    'unknown_action_default: NOT_CONFIGURED',
    'conflict_default: PENDING_REVIEW',
    'secret_policy: placeholders_only'
)) {
    if ($policy -notmatch [regex]::Escape($marker)) {
        throw "Plan-only policy missing required marker: $marker"
    }
}

foreach ($blockedAction in @(
    'DNS_WRITE_EXECUTION',
    'FTP_SFTP_WRITE_EXECUTION',
    'SQL_WRITE_EXECUTION',
    'ACCOUNTING_WRITE_EXECUTION',
    'WORKFLOW_WRITE_DISPATCH',
    'PRODUCTION_DEPLOYMENT_EXECUTION',
    'DESTRUCTIVE_OPERATION_EXECUTION',
    'DIRECT_PROVIDER_PUBLISH_EXECUTION',
    'BULK_SYNC_OR_DELETE_EXECUTION',
    'SECRET_READOUT',
    'PRIVATE_PAYLOAD_EXPORT'
)) {
    if ($policy -notmatch [regex]::Escape($blockedAction)) {
        throw "Plan-only policy missing blocked action: $blockedAction"
    }
}

$samplePlanPath = Join-Path $RepoRoot 'examples/plan-only/sample_provider_change_plan.json'
$samplePlanText = Get-Content $samplePlanPath -Raw
$samplePlan = $samplePlanText | ConvertFrom-Json

if ($samplePlan.mode -ne 'PLAN_ONLY') {
    throw "Sample plan mode must be PLAN_ONLY. Actual: $($samplePlan.mode)"
}

if ($samplePlan.executionAllowed -ne $false) {
    throw 'Sample plan top-level executionAllowed must be false.'
}

foreach ($gate in @('liveProviderWriteApproved', 'dnsWriteApproved', 'productionDeploymentApproved', 'destructiveOperationsApproved')) {
    if ($samplePlan.globalWriteGates.$gate -ne $false) {
        throw "Sample plan write gate $gate must be false."
    }
}

foreach ($step in $samplePlan.steps) {
    if ($step.executionAllowed -ne $false) {
        throw "Step $($step.stepId) has executionAllowed != false."
    }
    if ($step.actionClass -eq 'CONTROLLED_WRITE_PENDING_APPROVAL' -and -not $step.blockedReason) {
        throw "Controlled write step $($step.stepId) lacks blockedReason."
    }
}

$forbiddenPatterns = @(
    '(?i)api[_-]?key\s*[:=]\s*[^<\s]+',
    '(?i)bearer\s+[a-z0-9._\-]{12,}',
    '(?i)password\s*[:=]\s*[^<\s]+',
    '(?i)secret\s*[:=]\s*[^<\s]+'
)
foreach ($pattern in $forbiddenPatterns) {
    if ($samplePlanText -match $pattern) {
        throw "Sample plan appears to contain forbidden secret-like value matching: $pattern"
    }
}

Write-Host 'PASSED: O-RT3 plan-only policy verified.'
