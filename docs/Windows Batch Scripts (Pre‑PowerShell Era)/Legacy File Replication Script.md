# Legacy File Replication Script (Robocopy)

This page documents a legacy batch script used for automated file replication between two servers using **Robocopy**. It represents a common pre‑PowerShell automation pattern: simple, reliable, and easy to troubleshoot. This script is preserved here for historical context and for comparison with modern PowerShell‑based approaches.

---

## Overview

This script mirrors the contents of a source directory to a destination network share. It includes retry logic, wait intervals, and full logging. A second replication target is included as a commented‑out alternative.

This pattern was widely used in small office and departmental IT environments before PowerShell became the standard automation tool.

---

## Original Batch Script

```bat
robocopy C:\DataSource\  \\ServerA\SharedData\ /MIR /R:2 /W:10 /LOG:C:\Logs\replication_to_serverA.txt

#robocopy C:\DataSource\  \\ServerB\SharedData\ /MIR /R:2 /W:10 /LOG:C:\Logs\replication_to_serverB.txt
```

---

## Switch Breakdown

- **/MIR** — Mirror mode. Makes the destination identical to the source (adds new files, updates changed files, deletes removed files).
- **/R:2** — Retry failed copies up to 2 times.
- **/W:10** — Wait 10 seconds between retries.
- **/LOG:** — Writes all Robocopy output to the specified log file.

This combination provides a balance between reliability and speed, especially for nightly or hourly replication jobs.

---

## Why This Script Mattered

This script demonstrates several important legacy automation concepts:

- Using Robocopy as a lightweight replication engine  
- Maintaining mirrored directories between servers or NAS devices  
- Logging for audit and troubleshooting  
- Batch scripting as the primary automation method before PowerShell adoption  

It also highlights how administrators handled file synchronization without DFS, rsync, or modern orchestration tools.

---

## Modern PowerShell Equivalent

While Robocopy is still the best tool for Windows file replication, wrapping it in PowerShell provides better structure, error handling, and integration with modern automation workflows.

```powershell
$Source      = "C:\DataSource\"
$Destination = "\\ServerA\SharedData\"
$LogFile     = "C:\Logs\replication_to_serverA.txt"

Start-Process robocopy -ArgumentList @(
    "`"$Source`"",
    "`"$Destination`"",
    "/MIR",
    "/R:2",
    "/W:10",
    "/LOG:$LogFile"
) -NoNewWindow -Wait
```

This approach:

- Keeps Robocopy’s speed and reliability  
- Adds PowerShell’s structure and clarity  
- Makes it easier to integrate with scheduled tasks, monitoring, or larger scripts  

---

## When to Use Robocopy vs. PowerShell Cmdlets

Robocopy is still preferred when:

- You need **high‑performance** file replication  
- You want **mirror mode** with purge behavior  
- You need **robust retry logic**  
- You’re copying large directory trees  

PowerShell’s native cmdlets (`Copy-Item`, `Move-Item`) are better for:

- Small, simple copy operations  
- Scripts where readability matters more than speed  
- Cross‑platform automation (PowerShell Core)  

---

## Summary

This legacy script is a great example of early Windows automation practices. It remains relevant today as a simple, effective solution for file replication, and it provides a clear contrast to modern PowerShell‑based approaches.
