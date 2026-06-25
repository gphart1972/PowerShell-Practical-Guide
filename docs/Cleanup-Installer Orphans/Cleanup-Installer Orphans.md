This script was created to solve a problem at a previous employer involving excessive leftover files in the `C:\Windows\Installer` directory.  
Over time, various installers and Windows Updates had left behind hundreds of `.msi` and `.msp` files that were no longer referenced by the Windows Installer database. These orphaned files consumed significant disk space and could not be safely removed manually.

This script compares the contents of the `C:\Windows\Installer` folder against the list of packages and patches that Windows Installer *actually knows about*.  
Any file not referenced in the Windows Installer COM database is considered safe to remove.

To use this script:

1. Copy the code into a text editor (Notepad works fine).  
2. Save it as a `.ps1` file.  
3. Run it from an elevated PowerShell window (Run as Administrator).  
4. Review the output carefully — the script includes `-WhatIf` for safety.

---

## Script Version (`Cleanup-InstallerOrphans.ps1`)

```powershell
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
```

---

## Important Notes

- This script uses `-WhatIf` to prevent accidental deletion.  
  Remove `-WhatIf` only after verifying the output.
- This method is **safe** because it relies on Windows Installer’s internal database, not guesswork.
- This script is useful for:
  - Cleaning up orphaned `.msi` and `.msp` files  
  - Recovering disk space on servers  
  - Fixing systems where the Installer folder has ballooned in size  
