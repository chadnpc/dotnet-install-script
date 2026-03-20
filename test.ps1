
# .SYNOPSIS
# Tests the script
[CmdletBinding()]
param (
  [Parameter(Mandatory = $false, Position = 0)]
  [Alias('Module')][string]$ModulePath = $PSScriptRoot,
  # Path Containing Tests
  [Parameter(Mandatory = $false, Position = 1)]
  [Alias('Tests')][string]$TestsPath = [IO.Path]::Combine($PSScriptRoot, 'Tests')
)

$TestResults = Invoke-Pester -OutputFormat NUnitXml -OutputFile ([IO.Path]::Combine("Tests", "results.xml")) -PassThru

# ... do stuff with $TestResults