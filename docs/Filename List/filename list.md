# Generate a Simple Filename List from a Folder

This script provides a clean, minimal way to extract **only the filenames** from a target directory and write them to a UTF‑8 text file. It’s ideal for preprocessing large media collections, preparing for bulk renaming, or feeding filenames into classification workflows.

Unlike more complex renaming or parsing scripts, this tool focuses on a single task:  
**produce a plain list of filenames with zero transformation.**

---

## 📌 Description

This script:

- Reads all files (non-recursive) from a specified folder  
- Extracts only the **Name** property (no paths, no metadata)  
- Outputs the list to a UTF‑8 encoded `.txt` file  
- Confirms completion with a console message  

It’s intentionally simple, predictable, and safe — perfect for early‑stage organization work such as newsreel classification, Plex library prep, or batch renaming pipelines.

---

## 🧰 Usage

1. Set the `$Folder` variable to the directory you want to scan.  
2. Set the `$Output` variable to the desired output `.txt` file path.  
3. Run the script in PowerShell 5.1 or PowerShell 7+.  
4. Open the generated text file to review or process the filenames.

## 🧾 Script

```powershell
# Folder containing your newsreels
$Folder = "Z:\files\Video\newsreels"   # <-- change this to your actual path

# Output file
$Output = "C:\Scripts\file_list_to_text\newsreels_filelist.txt"

# Get filenames (no recursion)
Get-ChildItem -Path $Folder -File |
    Select-Object -ExpandProperty Name |
    Out-File -FilePath $Output -Encoding UTF8

Write-Host "File list written to $Output"
