$directory = "C:\example_path"

# Find all empty directories and delete them
Get-ChildItem $directory -Recurse -Directory | ForEach-Object {
    if ((Get-ChildItem $_.FullName -Force).Count -eq 0) {
        Write-Host "Deleting directory $($_.FullName)"
        Remove-Item $_.FullName
    }
}

Write-Host "Finished deleting empty directories"