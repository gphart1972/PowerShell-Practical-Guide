These two batch files were used at a previous employer to clean up broken or corrupted McAfee Agent installations.  
In that environment, the McAfee Agent frequently became stuck, partially uninstalled, or failed to update correctly.  
These scripts provided a quick, reliable way to remove the agent and clean up leftover framework files.

Although these scripts predate my PowerShell‑based automation work, they represent practical tools that solved real problems in the field and are included here for historical completeness.

---

## Script 1 — Remove McAfee Agent (`RemoveMcAfeeAgent.cmd`)

This script removes the McAfee Agent using the built‑in `frminst` uninstaller.

```batch
cd c:
cd "C:\Program Files\McAfee\agent\x86"
"C:\Program Files\McAfee\agent\x86\frminst" /remove=agent

rem Optional force uninstall (use only if needed)
rem "C:\Program Files\McAfee\agent\x86\frminst" /forceuninstall
```

### What this script does
- Navigates to the McAfee Agent installation directory  
- Runs the official McAfee removal tool  
- Uses `/remove=agent` to uninstall cleanly  
- Includes a commented `/forceuninstall` option for stubborn installs  

---

## Script 2 — Remove McAfee Framework Folder (`RemoveMcAfeeFramework.cmd`)

Some systems had leftover framework components even after the agent was removed.  
This script cleaned up the remaining Common Framework installation.

```batch
cd c:
cd "C:\Program Files (x86)\McAfee\Common Framework\x86"
"C:\Program Files (x86)\McAfee\Common Framework\x86\frminst" /remove=agent
```

### What this script does
- Navigates to the legacy McAfee Common Framework directory  
- Runs the same `frminst` removal tool  
- Cleans up older or partial installations  

---

## Why These Scripts Existed

These scripts were essential in environments where:

- McAfee Agent installations frequently became corrupted  
- Updates failed and left the agent in a broken state  
- The uninstall entry was missing or nonfunctional  
- Systems needed to be re‑enrolled in ePO  
- The previous IT admin left behind inconsistent or misconfigured deployments  

They provided a fast, repeatable way to restore systems to a clean state.
