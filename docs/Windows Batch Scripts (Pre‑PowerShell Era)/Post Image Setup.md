This script was created in 2018 to automate post‑imaging tasks for a customer environment.  
At the time, the environment This site had a PXE install system we had to use, but it had issues.
This site had no working SCCM (it was there but had only one app it deployed).
This script handled several required after‑image actions:

- Rebuilding the LaunchPage directory  
- Copying updated application files  
- Installing required software packages  
- Ensuring each installer ran silently and skipped if already installed  

Although this predates my PowerShell‑based automation work, it represents an important part of my early deployment tooling and is included here for historical completeness.

---

## Batch Script: `PostImageSetup.cmd`

```batch
rem Post‑image automation script
rem Created by Greg Hart – April 2018

rem Remove the existing LaunchPage folder
rmdir "C:\Program Files\LaunchPage" /Q /S

rem Recreate the LaunchPage folder
mkdir "C:\Program Files\LaunchPage"

rem Copy updated LaunchPage files
robocopy %~dp0missing\LaunchPage\ "C:\Program Files" /S /COPYALL

rem Install McAfee Agent (skips if already installed or newer)
%~dp0missing\MCAFEEAGENTNA5.0.3\framepkg.exe

rem Install Mimecast for Outlook (skips if already installed)
"%~dp0missing\mimecast\Mimecast For Outlook 7_WRAPPER.EXE"

rem Install OpenText Imaging Viewer (skips if already installed)
"%~dp0missing\OpenText Imaging Viewer\Open Text Imaging Windows Viewer 10.0.0_WRAPPER.EXE"

rem Install SAP GUI (skips if already installed)
"%~dp0missing\SAP_GUI_7.4\SAP GUI 7.4_WRAPPER.EXE"

rem Install Adobe Reader DC silently
"%~dp0missing\Adobe Reader DC 2015\AcroRdrDC1500720033_MUI.exe" /qn EULA_ACCEPT=YES AgreeToLicense=Yes RebootYesNo=No /sAll

rem Install OpenText Enterprise Connect (last because it triggers a restart)
"%~dp0missing\OPENTEXTENTERPRISECONNECT1052\OpenText Enterprise Connect Framework 10.5.2_WRAPPER.EXE"
```

---

## Why This Script Mattered  
This site had a PXE install system we had to use, but it had issues. This site had no working SCCM (it was there but had only one app it deployed).
This script automated a full suite of required applications after imaging, saving significant time and ensuring consistency across machines. It also:

- Reduced manual installation errors  
- Ensured correct versions were deployed  
- Standardized the environment  
- Supported environments where PowerShell automation wasn’t yet adopted  

It represents the kind of practical, boots‑on‑the‑ground automation that keeps enterprise environments running smoothly.



