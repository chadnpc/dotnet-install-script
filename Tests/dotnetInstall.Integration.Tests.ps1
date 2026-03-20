Describe "dotnet-install-script Integration Tests" {

  BeforeEach {
    $scriptPath = Join-Path $PSScriptRoot "..\Install-Dotnet.ps1"
    if (-not (Test-Path $scriptPath)) {
      $scriptPath = Join-Path (Get-Location) "Install-Dotnet.ps1"
    }
  }

  Context "Parameter Validation and Default Behavior" {

    It "Should execute a dry run for the LTS Channel without errors" {
      $output = & $scriptPath -DryRun 2>&1
      $output -join " " | Should -Match "Payload URLs"
      $output -join " " | Should -Match "Repeatable invocation"
    }

    It "Should generate dry run links for a specific runtime (aspnetcore)" {
      $output = & $scriptPath -Channel 8.0 -Runtime aspnetcore -DryRun 2>&1
      $output -join " " | Should -Match "aspnetcore-runtime"
      $output -join " " | Should -Not -Match "dotnet-sdk"
    }

    It "Should override channel when a specific version is provided" {
      $output = & $scriptPath -Version 8.0.100 -DryRun 2>&1
      $output -join " " | Should -Match "dotnet-sdk"
      $output -join " " | Should -Match "8.0.100"
    }

    It "Should throw an error if an invalid Runtime is passed" {
      { & $scriptPath -Runtime invalidruntime -DryRun } | Should -Throw "'invalidruntime' is not a supported value for -Runtime option."
    }

    It "Should throw an error if an invalid Architecture is passed" {
      { & $scriptPath -Architecture invalidarch -DryRun } | Should -Throw "Architecture 'invalidarch' not supported."
    }
  }
}
