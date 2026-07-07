# Invoke-ProtectedEndpointValidation.ps1
# O-RT12 operator-local GET-only endpoint validation wrapper.
# Writes sanitized summary JSON only. Does not write response bodies or auth values.

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$TargetId,

    [Parameter(Mandatory = $true)]
    [ValidateSet('public_health','protected_status','protected_mcp','repository_readiness','github_actions_readiness','connector_scope_review','governed_review')]
    [string]$Category,

    [Parameter(Mandatory = $true)]
    [string]$Uri,

    [string]$AuthEnvVarName,

    [string]$Operator = 'operator-local',

    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'

function New-ResultObject {
    param(
        [string]$ResultClass,
        [string]$HttpStatus,
        [string]$StatusSummary,
        [string]$FollowUpRequired
    )

    [pscustomobject]@{
        validationId = ('ORT12-' + $TargetId + '-' + (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ'))
        releaseTrain = 'O-RT12'
        targetId = $TargetId
        category = $Category
        timestampUtc = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
        operator = $Operator
        resultClass = $ResultClass
        httpStatus = $HttpStatus
        statusSummary = $StatusSummary
        evidenceReference = if ($OutputPath) { $OutputPath } else { 'local-output-not-specified' }
        followUpRequired = $FollowUpRequired
        sanitizationConfirmed = $true
    }
}

if (-not $OutputPath) {
    $safeTarget = $TargetId -replace '[^A-Za-z0-9_.-]', '_'
    $OutputPath = Join-Path 'artifacts/protected-endpoint-validation' ($safeTarget + '.json')
}

if ($Uri -notmatch '^https?://') {
    $result = New-ResultObject -ResultClass 'FAILED_VALIDATION' -HttpStatus 'not_run' -StatusSummary 'URI must start with http or https.' -FollowUpRequired 'correct_uri'
}
else {
    $headers = @{}
    if ($AuthEnvVarName) {
        $authValue = [Environment]::GetEnvironmentVariable($AuthEnvVarName)
        if ([string]::IsNullOrWhiteSpace($authValue)) {
            $result = New-ResultObject -ResultClass 'NOT_CONFIGURED' -HttpStatus 'not_run' -StatusSummary ('Required local environment variable was not present: ' + $AuthEnvVarName) -FollowUpRequired 'set_local_env_var_and_rerun'
        }
        else {
            $headers['Authorization'] = 'Bearer ' + $authValue
        }
    }

    if (-not $result) {
        $started = Get-Date
        try {
            $response = Invoke-WebRequest -Method GET -Uri $Uri -Headers $headers -UseBasicParsing -TimeoutSec 30
            $elapsedMs = [int]((Get-Date) - $started).TotalMilliseconds
            $statusCode = [string][int]$response.StatusCode
            $bodyLength = if ($null -ne $response.Content) { ([Text.Encoding]::UTF8.GetByteCount([string]$response.Content)) } else { 0 }
            $summary = 'GET completed; body omitted; bodyLength=' + $bodyLength + '; elapsedMs=' + $elapsedMs
            $class = if ([int]$response.StatusCode -ge 200 -and [int]$response.StatusCode -lt 300) {
                if ($Category -eq 'public_health') { 'READ_ONLY_READY' } else { 'PLAN_ONLY_READY' }
            } else {
                'PENDING_REVIEW'
            }
            $result = New-ResultObject -ResultClass $class -HttpStatus $statusCode -StatusSummary $summary -FollowUpRequired 'none'
        }
        catch {
            $result = New-ResultObject -ResultClass 'FAILED_VALIDATION' -HttpStatus 'request_failed' -StatusSummary ('GET failed; sanitized error class=' + $_.Exception.GetType().Name) -FollowUpRequired 'review_endpoint_or_network'
        }
    }
}

$outputDirectory = Split-Path -Parent $OutputPath
if ($outputDirectory -and -not (Test-Path $outputDirectory)) {
    New-Item -ItemType Directory -Force -Path $outputDirectory | Out-Null
}

$result | ConvertTo-Json -Depth 8 | Set-Content -Path $OutputPath -Encoding UTF8
Write-Host ('Wrote sanitized validation result: ' + $OutputPath)
