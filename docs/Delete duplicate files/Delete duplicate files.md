I created this script while consolidating files from several old personal computers.  
During that process, I discovered I had **far more duplicate files** than I wanted to deal with manually.  
To save time (and sanity), I wrote this PowerShell script to automatically detect and remove duplicates based on file hashes.

To use this script:

1. Copy the code into a text editor (Notepad works fine).  
2. Replace the example path with the directory you want to scan.  
3. Save the file with a `.ps1` extension.  
4. Run it from an elevated PowerShell window (Run as Administrator).

The script will recursively scan the directory, group files by their hash value, keep the first copy, and delete the duplicates.

```powershell
$directoryPath = "C:\path_example" # Replace with the path of the directory you want to search for duplicate files in

Write-Host "Searching for files in $($directoryPath)..."
# Get all files in the directory and its subdirectories
$files = Get-ChildItem -Path $directoryPath -Recurse -File

Write-Host "Grouping files by hash value..."
# Group the files by their hash (which will be the same for identical files)
$groups = $files | Group-Object -Property {$_.GetHashCode()}

Write-Host "Deleting duplicate files..."
# Loop through the groups of files, keeping only the first file in each group (i.e., the original file) and deleting the others
foreach ($group in $groups) {
    if ($group.Count -gt 1) {
        $originalFile = $group.Group[0]
        Write-Host "Keeping $($originalFile.FullName) and deleting $($group.Group[1..$($group.Count - 1)].FullName)"
        $group.Group[1..$($group.Count - 1)] | Remove-Item -Force
    }
}

Write-Host "Duplicate file removal complete."
```
