# Test-OrchestratorPrFirstChangePath.ps1
# O-RT5 PR-first controlled change path test.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$requiredFiles = @(
    'docs/ORT5_PR_FIRST_CONTROLLED_CHANGE_PATH_20260703.md',
    'config/pr-change-control.yml',
    'schemas/change-pack.schema.json',
    'templates/change-pack/PR_FIRST_CHANGE_PACK_TEMPLATE.md',
    'examples/change-packs/sample_pr_first_change_pack.json',
    '.github/PULL_REQUEST_TEMPLATE/orchestrator-controlled-change.md'
)

foreach ($file in $requiredFiles) {
    $path = Join-Path $RepoRoot $file
    if (-not (Test-Path $path)) {
        throw "Missing O-RT5 required file: $file"
    }
}

$policy = Get-Content (Join-Path $RepoRoot 'config/pr-change-control.yml') -Raw
foreach ($marker in @(
    'mode: PR_FIRST_CONTROLLED_CHANGE',
    'execution_allowed: false',
    'live_write_approved: false',
    'auto_merge_allowed: false',
    'auto_deploy_allowed: false',
    'provider_write_allowed: false',
    'production_write_allowed: false',
    'human_review_required: true',
    'deployment_decision_separate_from_merge: true'
)) {
    if ($policy -notmatch [regex]::Escape($marker)) {
        throw "PR change-control policy missing marker: $marker"
    }
}

foreach ($blocked in @(
    'DIRECT_MAIN_BRANCH_WRITE_FOR_FEATURE_CHANGE',
    'AUTO_MERGE',
    'AUTO_DEPLOY',
    'DNS_WRITE',
    'FTP_SFTP_WRITE',
    'SQL_WRITE',
    'ACCOUNTING_WRITE_OR_SUBMISSION',
    'PRODUCTION_DEPLOYMENT',
    'DESTRUCTIVE_OPERATION',
    'DIRECT_PROVIDER_PUBLISH'
)) {
    if ($policy -notmatch [regex]::Escape($blocked)) {
        throw "PR change-control policy missing blocked action: $blocked"
    }
}

$prTemplate = Get-Content (Join-Path $RepoRoot '.github/PULL_REQUEST_TEMPLATE/orchestrator-controlled-change.md') -Raw
foreach ($marker in @(
    'Human review required before merge',
    'Merge approval does not approve deployment',
    'Deployment approval is separate',
    'Provider write approval is separate'
)) {
    if ($prTemplate -notmatch [regex]::Escape($marker)) {
        throw "PR template missing marker: $marker"
    }
}

Write-Host 'PASSED: O-RT5 PR-first change path verified.'
