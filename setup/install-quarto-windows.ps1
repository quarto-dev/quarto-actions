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
    $scoopShims = Join-Path (Resolve-Path ~).Path "scoop\shims"
    Add-Content -Path $Env:GITHUB_PATH -Value $scoopShims
} catch {
    Write-Error "Failed to download or install Scoop: $_"
    exit 1
}

$version=$args[0]
scoop bucket add r-bucket https://github.com/cderv/r-bucket.git

if ([string]::IsNullOrEmpty($version)) {
    scoop install quarto
} elseif ($version -eq 'pre-release') {
    scoop install quarto-prerelease
} else {
    scoop install quarto@$version
}
