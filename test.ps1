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

begin {
  $originalErrorActionPreference = $ErrorActionPreference
  $ErrorActionPreference = "Stop"
  # resolve requirements
  $requiredmodules = @(
    'Pester',
    'clihelper.env',
    'clihelper.logger'
  )

  foreach ($module in $requiredmodules) {
    if (!(Get-Module -ListAvailable $module -ea Ignore)) {
      Write-Warning "$module is not installed. Installing $module for testing..."
      Install-Module $module -Force -Scope CurrentUser
    }
    Import-Module $module -Verbose:$false -Force
  }
}
process {
  Write-Host "Running Pester tests from '$TestsPath'..." -ForegroundColor Cyan

  $TestResults = Invoke-Pester -Path $TestsPath -OutputFormat NUnitXml -OutputFile ([IO.Path]::Combine($TestsPath, "results.xml")) -PassThru

  if ($TestResults.FailedCount -gt 0) {
    Write-Error "Tests failed. Look at results.xml for more details."
  }
}

end {
  $ErrorActionPreference = $originalErrorActionPreference
  Write-Host "All tests ran successfully!" -ForegroundColor Green
  exit 0
}
