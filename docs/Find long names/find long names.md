I created this script to solve a file‑migration issue at a previous employer.  
Some users had extremely long file paths — long enough to break backup tools, migration utilities, and even basic file operations.  
To quickly identify problematic paths, I wrote this PowerShell command to locate any files or folders exceeding the traditional 260‑character limit.

To use this script:

1. Copy the code into a text editor (Notepad works fine).  
2. Replace the example path if needed.  
3. Save the file with a `.ps1` extension if you want a reusable script.  
4. Run it from an elevated PowerShell window (Run as Administrator).

Below are two versions:  
- A **one‑liner** for quick use  
- A **script version** for `.ps1` files

---

## One‑Liner Version

```powershell
Get-ChildItem -Recurse | Where-Object { $_.FullName.Length -gt 260 } | Select-Object -ExpandProperty FullName
```

This will scan the current directory recursively and output any paths longer than 260 characters.

---

## Script Version (`Find-LongPaths.ps1`)

```powershell
param(
    [string]$Path = "C:\example_path",
    [int]$MaxLength = 260
)

Write-Host "Scanning for long paths in $Path..."

Get-ChildItem -Path $Path -Recurse | ForEach-Object {
    if ($_.FullName.Length -gt $MaxLength) {
        Write-Host "Long path detected ($($_.FullName.Length) chars):"
        Write-Host $_.FullName
        Write-Host ""
    }
}

Write-Host "Scan complete."
```

This version is reusable, configurable, and easier to maintain.  
You can run it like this:

```powershell
.\Find-LongPaths.ps1 -Path "C:\Users" -MaxLength 260
```
