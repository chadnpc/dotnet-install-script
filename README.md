# dotnet-install-script

A custom cross-platform compatible PowerShell script to install the .NET SDK and Runtime.
This script is intended primarily for Continuous Integration (CI) scenarios where you need to install without user interaction, without admin rights, and where it doesn't need to persist.

## Usage

```PowerShell
# To install the script as a module/script
Install-Script -Name Install-Dotnet -Scope CurrentUser -Force

# Or use it directly by cloning the repo
.\Install-Dotnet.ps1 -Channel LTS
```

## Parameters

- `-Channel` (Default: `LTS`): Download from specified channel (`LTS`, `STS`, or version like `8.0`).
- `-Quality`: Download latest build of specified quality (`daily`, `preview`, `GA`).
- `-Version` (Default: `latest`): Specific build version (`latest`, or `3-part version` like `8.0.100`).
- `-Runtime`: Installs only the shared runtime instead of the entire SDK (`dotnet`, `aspnetcore`, `windowsdesktop`).
- `-InstallDir` (Default: `<auto>` -> `%LocalAppData%\Microsoft\dotnet`): Path to install binaries.
- `-Architecture` (Default: `<auto>`): System architecture (`x64`, `x86`, `arm64`, `arm`).
- `-DryRun`: Displays the repeatable command line to be used instead of performing the installation.
- `-NoPath`: Do not add the installation directory to the current process's `PATH`.

For more help run

```PowerShell
Get-Help .\Install-Dotnet.ps1 -Full
```

## Examples

**Install the latest LTS SDK:**
```PowerShell
.\Install-Dotnet.ps1
```

**Install a specific SDK version:**
```PowerShell
.\Install-Dotnet.ps1 -Version 8.0.100
```

**Install the latest ASP.NET Core Runtime for version 8.0:**
```PowerShell
.\Install-Dotnet.ps1 -Channel 8.0 -Runtime aspnetcore
```

**Dry Run to get deterministic payload URLs without installing:**
```PowerShell
.\Install-Dotnet.ps1 -Channel LTS -DryRun
```

## Uninstall

```PowerShell
Uninstall-Script -Name Install-Dotnet -Scope CurrentUser -Force
```

## License

This script is licensed under the MIT license. See the [LICENSE](LICENSE) file for more information.