I created this script to solve a log‑management problem at a previous employer.  
Their development team had implemented custom logging for a server application, but they had no built‑in support for **circular logging** or automatic cleanup.  
Over time, the number of log files grew so large that it began consuming significant disk space.

After meeting with the dev team and agreeing on how many days of logs they needed to retain, I wrote this PowerShell script to automatically delete older log files and keep the system healthy.

To use this script:

1. Copy the code into a text editor (Notepad works fine).  
2. Replace the example path with your log directory.  
3. Save the file with a `.ps1` extension.  
4. Run it manually or schedule it to run daily using Windows Task Scheduler.

---

## One‑Liner Version

```powershell
Get-ChildItem -Path "C:\example_path" -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item
```

This removes any file older than **7 days**.

---

## Script Version (`Cleanup-OldLogs.ps1`)

```powershell
param(
    [string]$Path = "C:\example_path",
    [int]$DaysToKeep = 7
)

Write-Host "Cleaning up log files older than $DaysToKeep days in $Path..."

$cutoff = (Get-Date).AddDays(-$DaysToKeep)

Get-ChildItem -Path $Path -Recurse -File | ForEach-Object {
    if ($_.LastWriteTime -lt $cutoff) {
        Write-Host "Deleting $($_.FullName)"
        Remove-Item $_.FullName -Force
    }
}

Write-Host "Log cleanup complete."
```

Run it like this:

```powershell
.\Cleanup-OldLogs.ps1 -Path "C:\Logs\App" -DaysToKeep 14
```

---

## Adding This Script as a Scheduled Task (PowerShell Method)

Below is a clean, modern example of how to register this script as a scheduled task that:

- Runs **daily**
- Runs **whether a user is logged in or not**
- Runs with **highest privileges**
- Uses **PowerShell 7** if installed

```powershell
$Action = New-ScheduledTaskAction -Execute "pwsh.exe" -Argument "-File `"`"C:\Scripts\Cleanup-OldLogs.ps1`"`""
$Trigger = New-ScheduledTaskTrigger -Daily -At 3am
$Principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -RunLevel Highest
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

Register-ScheduledTask -TaskName "CleanupOldLogs" -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings
```

### Notes:
- This runs as **SYSTEM**, which avoids credential prompts and ensures it runs even when no user is logged in.  
- If you prefer running under a specific service account, replace `"SYSTEM"` with the username.  
- Adjust the time (`-At 3am`) as needed.


