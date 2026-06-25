Function Clean-Up ([String]$FileType, [Array]$Data)
{
    # Read list of files from C:\Windows\Installer
    $InstallerFiles = Get-ChildItem "C:\Windows\Installer" "*.$FileType" -File

    foreach ($InstallerFile in $InstallerFiles)
    {
        # If Windows Installer does not reference this file,
        # it is considered orphaned and can be removed.
        if (!($Data | Where-Object { $_ -eq $InstallerFile.FullName }))
        {
            Write-Host "Orphan detected: $($InstallerFile.FullName)"
            Remove-Item -Path $InstallerFile.FullName -Force -ErrorAction Continue -WhatIf
        }
    }
}

# Initialize arrays
[array]$PatchesLocation = @()
[array]$InstallersLocation = @()

# Query Windows Installer COM object
$Installer = New-Object -ComObject "WindowsInstaller.Installer"
$Products = $Installer.Products()

# Enumerate installed products and their patches
foreach ($ProductCode in $Products)
{
    # Add .msi file path
    $InstallersLocation += $Installer.ProductInfo($ProductCode, "LocalPackage")

    # Add .msp patch file paths
    $Patches = $Installer.Patches($ProductCode)
    foreach ($PatchCode in $Patches)
    {
        $PatchesLocation += $Installer.PatchInfo($PatchCode, "LocalPackage")
    }
}

# Compare and clean up orphaned files
if ($PatchesLocation.Count -ne 0)
{
    Clean-Up -FileType "msp" -Data $PatchesLocation
}

if ($InstallersLocation.Count -ne 0)
{
    Clean-Up -FileType "msi" -Data $InstallersLocation
}