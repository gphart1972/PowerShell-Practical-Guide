I created this script to solve a problem where I had several hundred files, each stored inside its own individual folder.  
I needed all of those files moved into a single directory, and doing it manually would have taken forever.  
This simple PowerShell command automates the process by recursively scanning a source directory and moving every file into a single destination folder.

To use this script:

1. Copy the code into a text editor (Notepad works fine).  
2. Replace the example paths with your own.  
3. Save the file with a `.ps1` extension.  
4. Run it from an elevated PowerShell window (Run as Administrator).

---

## One‑Liner Version

```powershell
Get-ChildItem -Path "C:\source_path_example" -Recurse | Move-Item -Destination "C:\destination_path_example"
```

This command:

- Recursively scans the source directory  
- Finds all files  
- Moves them into the destination directory  
- Leaves the empty folders behind (you can delete them with an empty‑folder script)

---

## Script Version (`Flatten-Folder.ps1`)

```powershell
param(
    [string]$Source = "C:\source_path_example",
    [string]$Destination = "C:\destination_path_example"
)

Write-Host "Moving all files from $Source to $Destination..."

# Ensure the destination exists
if (-not (Test-Path $Destination)) {
    Write-Host "Destination does not exist. Creating it..."
    New-Item -ItemType Directory -Path $Destination | Out-Null
}

# Move all files recursively
Get-ChildItem -Path $Source -Recurse -File | ForEach-Object {
    Write-Host "Moving $($_.FullName)"
    Move-Item -Path $_.FullName -Destination $Destination -Force
}

Write-Host "File flattening complete."
```

Run it like this:

```powershell
.\Flatten-Folder.ps1 -Source "C:\Stuff\Nested" -Destination "C:\Stuff\Flat"
```

- [Moving files with PowerShell](ca://s?q=powershell_move_item)

