# Test-OrchestratorOpenApiGetOnly.ps1
# O-RT2 OpenAPI GET-only validation.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$openApiPath = Join-Path $RepoRoot 'openapi/orchestrator-readonly.openapi.json'
if (-not (Test-Path $openApiPath)) {
    throw 'Missing OpenAPI schema: openapi/orchestrator-readonly.openapi.json'
}

$schema = Get-Content $openApiPath -Raw | ConvertFrom-Json

if ($schema.'x-runtime-contract' -ne 'GET_ONLY') {
    throw "OpenAPI x-runtime-contract must be GET_ONLY. Actual: $($schema.'x-runtime-contract')"
}

if ($schema.'x-live-write-approved' -ne $false) {
    throw 'OpenAPI schema incorrectly marks live write as approved.'
}

$paths = $schema.paths.PSObject.Properties
if ($paths.Count -eq 0) {
    throw 'OpenAPI schema contains no paths.'
}

$forbiddenMethods = @('post', 'put', 'patch', 'delete')
foreach ($pathProperty in $paths) {
    $pathName = $pathProperty.Name
    $pathItem = $pathProperty.Value

    if (-not ($pathItem.PSObject.Properties.Name -contains 'get')) {
        throw "Path does not expose GET: $pathName"
    }

    foreach ($method in $forbiddenMethods) {
        if ($pathItem.PSObject.Properties.Name -contains $method) {
            throw "Path exposes forbidden method $method at $pathName"
        }
    }

    $getOperation = $pathItem.get
    if ($getOperation.'x-action-class' -ne 'READ_ONLY_READY') {
        throw "GET operation at $pathName is not READ_ONLY_READY. Actual: $($getOperation.'x-action-class')"
    }
}

$globalWriteGates = $schema.components.schemas.GlobalWriteGates.properties
foreach ($gate in @('liveProviderWriteApproved', 'dnsWriteApproved', 'productionDeploymentApproved', 'destructiveOperationsApproved')) {
    if ($globalWriteGates.$gate.const -ne $false) {
        throw "Global write gate $gate is not const false."
    }
}

Write-Host 'PASSED: O-RT2 OpenAPI schema is GET-only and write gates are false.'
