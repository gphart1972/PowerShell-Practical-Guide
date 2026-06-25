# 🖥️ PowerShell Domain Join Automation

This script automates joining a Windows computer to an Active Directory domain and configures DNS settings. A mass deployment scenario where this is deployed via some automation of sorts.

---

## ✅ Features

- Detects active physical network adapter
- Sets DNS servers automatically
- Joins system to domain
- Optional restart

---

## ⚙️ Requirements

- Run as Administrator
- Network access to Domain Controller
- Domain credentials

---

## 🚀 Example Usage from the powershell command line:

```powershell
.\join-domain.ps1 -DomainName "example.com" -DnsServers "192.168.1.10","192.168.1.11"
```
🔹 Example usage in a PowerShell script file:
```powershell
param(
    [string]$DomainName = "example.com",
    [string[]]$DnsServers = @("xxx.xxx.xxx.xxx", "xxx.xxx.xxx.xxx")
)

# Get active physical adapter
$adapter = Get-NetAdapter |
    Where-Object {
        $_.Status -eq "Up" -and
        $_.Virtual -eq $false
    }

Write-Host "Configuring DNS servers..." -ForegroundColor Yellow

Set-DnsClientServerAddress `
    -InterfaceAlias $adapter.Name `
    -ServerAddresses $DnsServers

Write-Host "Joining domain: $DomainName" -ForegroundColor Yellow

try {
    Add-Computer `
        -DomainName $DomainName `
        -Credential (Get-Credential) `
        -Restart `
        -ErrorAction Stop
}
catch {
    Write-Host "Domain join failed: $_" -ForegroundColor Red
}

```
