# Copy Folder Structure
You can recreate the folder structure using Get-ChildItem + New-Item:
```powershell
$source = "C:\SourceFolder"
$destination = "C:\EmptyFolder"

Get-ChildItem -Path $source -Recurse -Directory | ForEach-Object {
    $newPath = $_.FullName.Replace($source, $destination)
    New-Item -ItemType Directory -Path $newPath -Force | Out-Null
}
```
Save that as a '.ps1' file with your paths for 'source' and 'destination'

✅ What this does

- Scans all folders in the source (-Recurse -Directory)
- Rebuilds the same relative path in the destination
- Creates only folders (no files)
