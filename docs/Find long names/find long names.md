I originally wrote this script to troubleshoot a file‑migration issue at a previous employer.  
Some users had extremely long file paths — long enough to break backup tools, migration utilities, and even basic file operations.  
To quickly identify these problematic paths, I created a PowerShell script that scans a directory and reports any paths exceeding the traditional 260‑character limit.

To use this script:

1. Copy the code into a text editor (Notepad works fine).  
2. Replace the example path with the directory you want to scan.  
3. Save the file with a `.ps1` extension.  
4. Run it from an elevated PowerShell window (Run as Administrator).

Below are two versions:  
- A **one‑liner** for quick checks  
- A **full script** that outputs results to TXT or CSV (with toggles)

---

## One‑Liner Version

```powershell
Get-ChildItem -Recurse | Where-Object { $_.FullName.Length -gt 260 } | Select-Object -ExpandProperty FullName
```

---

## Script Version (`Find-LongPaths.ps1`)  
Includes toggles for **TXT** and **CSV** output.

```powershell
param(
    [string]$Path = "C:\example_path",
    [int]$MaxLength = 260,

    # Toggle output formats ON/OFF
    [bool]$WriteTxt = $true,
    [bool]$WriteCsv = $true,

    # Output file paths
    [string]$OutputTxt = ".\LongPaths.txt",
    [string]$OutputCsv = ".\LongPaths.csv"
)

Write-Host "Scanning for long paths in $Path..."

# Collect long paths
$results = Get-ChildItem -Path $Path -Recurse | ForEach-Object {
    if ($_.FullName.Length -gt $MaxLength) {
        [PSCustomObject]@{
            Length = $_.FullName.Length
            Path   = $_.FullName
        }
    }
}

if ($results.Count -eq 0) {
    Write-Host "No long paths found."
    return
}

# -----------------------------
# TXT OUTPUT (toggle with $WriteTxt)
# -----------------------------
if ($WriteTxt) {
    Write-Host "Writing TXT output to $OutputTxt..."
    $results.Path | Out-File -FilePath $OutputTxt -Encoding UTF8
}

# -----------------------------
# CSV OUTPUT (toggle with $WriteCsv)
# -----------------------------
if ($WriteCsv) {
    Write-Host "Writing CSV output to $OutputCsv..."
    $results | Export-Csv -Path $OutputCsv -NoTypeInformation -Encoding UTF8
}

Write-Host "Scan complete."
Write-Host "TXT output: $OutputTxt (Enabled: $WriteTxt)"
Write-Host "CSV output: $OutputCsv (Enabled: $WriteCsv)"
```

---

### How to Toggle Output Formats

- **Disable TXT output:**  
  ```powershell
  -WriteTxt:$false
  ```

- **Disable CSV output:**  
  ```powershell
  -WriteCsv:$false
  ```

- **Disable both (console‑only):**  
  ```powershell
  -WriteTxt:$false -WriteCsv:$false
  ```
