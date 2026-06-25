This batch script is a fun relic from my early IT days (around 2010).  
I used to keep it running on my screen so it looked like I was actively monitoring network activity.  
It continuously looped through `ping`, `netstat`, and other commands to create the illusion of a busy console.

While it’s not technically useful today, it’s included here as a lighthearted piece of sysadmin history — a reminder of the era before PowerShell, automation pipelines, and modern monitoring dashboards.

---

## “Fake Busy” Loop Script (`FakeBusy.cmd`)

```batch
@echo off
if not exist %0 goto ERROR
if not "%1"=="" goto %1

color 0a

:MAIN
call %0 GOOGLE
call %0 NETSTAT
call %0 ABC
goto DONE

:NETSTAT
netstat -e -s
goto GOOGLE

:GOOGLE
ping www.google.com
::tracert www.google.com
goto ABC

:ABC
ping www.abc.com
::tracert www.abc.com
goto MAIN

:ERROR
echo.
echo You must run this batch file with its full name (including the extension).
echo If you run it from another directory, you must include the path as well.
echo If you include the path, it should be the short path (or at least not
echo include spaces). Running it by typing "%0" isn't good enough!
echo Double-clicking this batch file in Windows Explorer will work just fine...
echo.
goto DONE

:DONE
goto MAIN
```

---

## Why This Script Existed

Back in the Windows XP / Windows 7 era, IT workstations didn’t always have dashboards, RMM consoles, or real‑time monitoring tools visible on screen.  
Sometimes you just needed:

- A scrolling console  
- A few network commands  
- Something that *looked* like active diagnostics  
- A reason for people to walk by and think, “Oh, he’s working on something important”  

This script did exactly that.

## Additional Note

Although this script started as a lighthearted way to keep a busy-looking console on screen, it also doubled as a quick and simple **network connectivity check**.  
The repeated use of `ping` and `netstat` provided a rolling view of:

So even as a “fun” script, it still offered real diagnostic value.

