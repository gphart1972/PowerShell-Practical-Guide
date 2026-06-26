# WinSxS Component Store Cleanup (DISM)

Windows stores multiple versions of system components inside the **WinSxS** folder.  
Over time — especially on servers or systems that receive many cumulative updates — this folder can grow significantly.  
A bloated WinSxS folder can cause:

- Low disk space on the C: drive  
- Windows Update failures  
- Slow servicing operations  
- General system sluggishness  

The following DISM command performs a **safe, Microsoft‑supported cleanup** of superseded components.

---

## Basic Component Cleanup

**Command:**  
```code  
Dism.exe /Online /Cleanup-Image /StartComponentCleanup  
```
### What this does:
- Removes superseded component versions  
- Reduces the size of the WinSxS folder  
- Improves Windows servicing performance  
- Does **not** remove anything required for future updates  
- Does **not** require a reboot  

### When to use it:
- Low disk space on the system drive  
- Windows Update errors related to component store corruption  
- Monthly or quarterly maintenance  
- After installing large cumulative updates  

### Notes:
- Safe for production systems  
- Can be run during normal operation  
- Can be automated via Scheduled Task  

---

## Optional: Deep Cleanup Variant

**Command:**  
```code 
Dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase  
```
### What `/ResetBase` does:
- Makes all currently installed updates permanent  
- Removes the ability to uninstall any existing updates  
- Further reduces WinSxS size  

### When to use it:
- On stable systems where uninstalling updates is not needed  
- On servers or appliances that rarely change  
- When maximum disk cleanup is required  

### Warning:
- After running `/ResetBase`, you **cannot** uninstall any update that was installed prior to running the command.  
- Use only when you are confident the system is stable.

---

## Recommended Usage Pattern

For most environments:

1. Run the standard cleanup first  
```code
   Dism.exe /Online /Cleanup-Image /StartComponentCleanup  
```
2. Verify system stability  
3. Optionally run the `/ResetBase` variant if deeper cleanup is desired  

---

## Automation Tip

This command can be added to a Scheduled Task to run monthly as part of a maintenance routine.  
It keeps Windows lean, reduces update issues, and prevents disk‑space emergencies.

---

## Summary

The DISM component cleanup is:

- Safe  
- Supported  
- Useful  
- Non-destructive  
- Ideal for both servers and desktops  

It’s one of the most effective Windows maintenance commands and absolutely belongs in your PowerShell guide.
