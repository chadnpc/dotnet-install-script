# Contributing to dotnet-install-script

We welcome contributions to the `dotnet-install-script` project!

## Getting Started

1. **Clone the repository:**
   ```PowerShell
   git clone https://github.com/chadnpc/dotnet-install-script.git
   cd dotnet-install-script
   ```

2. **Environment Setup (Optional):**
   ```PowerShell
   cp .env.example .env
   ```

## Testing

Before submitting your changes, ensure that all tests pass. We use [Pester](https://pester.dev/) for testing.

1. **Run the tests locally:**
   ```PowerShell
   .\test.ps1
   ```

   This script will invoke Pester and run all `.Tests.ps1` files in the `Tests` directory.

2. **If all tests pass**, you're ready to commit and create a pull request!

## Publishing (Maintainers Only)

Add your real api key in `.env` file

To publish a new version of the module:

```PowerShell
Read-Env .env | Set-Env
Publish-Script -Path .\Install-Dotnet.ps1 -NuGetApiKey $env:NUGET_API_KEY
```
