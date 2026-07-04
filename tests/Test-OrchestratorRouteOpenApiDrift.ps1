# Test-OrchestratorRouteOpenApiDrift.ps1
# O-RT4 route map vs OpenAPI drift test.

[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

$ErrorActionPreference = 'Stop'

$routeMapPath = Join-Path $RepoRoot 'config/read-only-routes.yml'
$openApiPath = Join-Path $RepoRoot 'openapi/orchestrator-readonly.openapi.json'

foreach ($path in @($routeMapPath, $openApiPath)) {
    if (-not (Test-Path $path)) {
        throw "Missing required drift input: $path"
    }
}

$routeMap = Get-Content $routeMapPath -Raw
$openApi = Get-Content $openApiPath -Raw | ConvertFrom-Json

$routePaths = [regex]::Matches($routeMap, 'path:\s*(/orchestrator/v1/[^\r\n]+)') | ForEach-Object { $_.Groups[1].Value.Trim() } | Sort-Object -Unique
$openApiPaths = $openApi.paths.PSObject.Properties.Name | Sort-Object -Unique

if ($routePaths.Count -eq 0) {
    throw 'No route paths found in config/read-only-routes.yml.'
}

foreach ($routePath in $routePaths) {
    if ($openApiPaths -notcontains $routePath) {
        throw "Route map path missing from OpenAPI schema: $routePath"
    }
}

foreach ($openApiPathName in $openApiPaths) {
    if ($routePaths -notcontains $openApiPathName) {
        throw "OpenAPI path missing from route map: $openApiPathName"
    }
}

foreach ($pathProperty in $openApi.paths.PSObject.Properties) {
    $pathName = $pathProperty.Name
    $pathItem = $pathProperty.Value
    if (-not ($pathItem.PSObject.Properties.Name -contains 'get')) {
        throw "OpenAPI path lacks GET method: $pathName"
    }
    foreach ($forbidden in @('post', 'put', 'patch', 'delete')) {
        if ($pathItem.PSObject.Properties.Name -contains $forbidden) {
            throw "OpenAPI path exposes forbidden method $forbidden at $pathName"
        }
    }
}

if ($routeMap -match 'method:\s*(POST|PUT|PATCH|DELETE)') {
    throw 'Route map exposes a forbidden non-GET method.'
}

Write-Host 'PASSED: O-RT4 route/OpenAPI drift check passed.'
