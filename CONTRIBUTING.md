# Contributing

```PowerShell
git clone https://github.com/chadnpc/dotnet-install-script.git
cd dotnet-install-script
```

```PowerShell
cp .env.example .env
```

make your changes, then run the test scripts

```PowerShell
test.ps1
```

If the tests pass, then you can commit your changes.

Create a pull request.

# publish

```PowerShell
Publish-Module -Path BuildOutput/dotnetInstall.xconvert/0.1.3 -NuGetApiKey $env:NUGET_API_KEY
```
