<#
    .Synopsis
    Install Quarto release through Scoop package manager
    .Description
    Install Scoop then add r-bucket, and install Quarto from there.
    .Example
    install-quarto-windows.ps1
    .Notes
    On Windows, it may be required to enable this Activate.ps1 script by setting the
    execution policy for the user. You can do this by issuing the following PowerShell
    command:
    PS C:\> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    For more information on Execution Policies: 
    ttps:/go.microsoft.com/fwlink/?LinkID=135170
#>

# Exit immediately on errors
$ErrorActionPreference = "Stop"

try {
    Invoke-WebRequest -useb get.scoop.sh -outfile 'install.ps1'
    .\install.ps1 -RunAsAdmin
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Scoop installation failed with exit code $LASTEXITCODE"
        exit 1
    }
    Join-Path (Resolve-Path ~).Path "scoop\shims" >> $Env:GITHUB_PATH
} catch {
    Write-Error "Failed to download or install Scoop: $_"
    exit 1
}

$version=$args[0]
scoop bucket add r-bucket https://github.com/cderv/r-bucket.git
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to add r-bucket with exit code $LASTEXITCODE"
    exit 1
}

if ([string]::IsNullOrEmpty($version)) {
    scoop install quarto
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to install quarto with exit code $LASTEXITCODE"
        exit 1
    }
} elseif ($version -eq 'pre-release') {
    Invoke-Expression -Command "scoop install quarto-prerelease"
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to install quarto-prerelease with exit code $LASTEXITCODE"
        exit 1
    }
} else {
    Invoke-Expression -Command "scoop install quarto@$version"
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to install quarto version $version with exit code $LASTEXITCODE"
        exit 1
    }
}

# Verify Quarto is available
$quartoPath = Get-Command quarto -ErrorAction SilentlyContinue
if (-not $quartoPath) {
    Write-Error "Quarto installation completed but quarto command not found in PATH"
    exit 1
}

exit 0
