# .SYNOPSIS
# Runs Pester tests for the project and returns an appropriate exit code.
[CmdletBinding()]
param (
  [Parameter(Mandatory = $false, Position = 0)]
  [Alias('Module')][string]$ModulePath = $PSScriptRoot,

  # Path Containing Tests
  [Parameter(Mandatory = $false, Position = 1)]
  [Alias('Tests')][string]$TestsPath = [IO.Path]::Combine($PSScriptRoot, 'Tests')
)

$ErrorActionPreference = "Stop"

if (-not (Get-Module -ListAvailable Pester)) {
  Write-Warning "Pester is not installed. Installing Pester for testing..."
  Install-Module Pester -Force -SkipPublisherCheck -Scope CurrentUser
}

Import-Module Pester -Verbose:$false

Write-Host "Running Pester tests from '$TestsPath'..." -ForegroundColor Cyan

$TestResults = Invoke-Pester -Path $TestsPath -OutputFormat NUnitXml -OutputFile ([IO.Path]::Combine($TestsPath, "results.xml")) -PassThru

if ($TestResults.FailedCount -gt 0) {
  Write-Error "Tests failed. Look at results.xml for more details."
  exit 1
}

Write-Host "All tests ran successfully!" -ForegroundColor Green
exit 0