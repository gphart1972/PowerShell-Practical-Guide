I created this script while doing a large personal data consolidation project.  
During that process, I discovered I had **hundreds of empty folders** scattered across multiple drives.  
Instead of checking and deleting them one by one, I wrote this PowerShell script to automate the cleanup.

To use this script:

1. Copy the code into a text editor (Notepad works fine).  
2. Replace the example path with the directory you want to scan.  
3. Save the file with a `.ps1` extension.  
4. Run it from an elevated PowerShell window (Run as Administrator).

The script will search the target directory recursively, identify empty folders, and remove them automatically.

```powershell
$directory = "C:\example_path"

# Find all empty directories and delete them
Get-ChildItem $directory -Recurse -Directory | ForEach-Object {
    if ((Get-ChildItem $_.FullName -Force).Count -eq 0) {
        Write-Host "Deleting directory $($_.FullName)"
        Remove-Item $_.FullName
    }
}

Write-Host "Finished deleting empty directories"
```
