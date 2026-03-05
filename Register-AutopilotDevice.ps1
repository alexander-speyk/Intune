<#
.SYNOPSIS
    Registreert de huidige machine in Windows Autopilot en logt het proces.
    
.NOTES
    Script gemaakt door: Alexander Zoutenbier
    Functie: Solution Architect SPEYK

.DESCRIPTION
    Overschrijft ExecutionPolicy en uploadt de hardware hash naar Intune.
#>

# 1. Omgeving voorbereiden
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
$LogPath = "C:\Temp"
$LogFile = Join-Path $LogPath "AutopilotRegistration.log"
$ErrorActionPreference = "Stop"

if (-not (Test-Path $LogPath)) {
    try { New-Item -ItemType Directory -Path $LogPath -Force | Out-Null } catch { }
}

Start-Transcript -Path $LogFile -Append

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  Autopilot Registratie Script" -ForegroundColor Cyan
Write-Host "  Gemaakt door: Alexander Zoutenbier (SPEYK)" -ForegroundColor White
Write-Host "==========================================================" -ForegroundColor Cyan

try {
    Write-Host "[1/3] NuGet provider configureren..." -ForegroundColor Gray
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null

    Write-Host "[2/3] Autopilot tools downloaden uit de Gallery..." -ForegroundColor Gray
    Install-Script -Name Get-WindowsAutopilotInfo -Force -Confirm:$false

    Write-Host "[3/3] Starten van hardware hash upload. Log in bij de Microsoft prompt..." -ForegroundColor Yellow
    
    # We hebben -AddEventListener verwijderd om compatibiliteitsproblemen te voorkomen
    Get-WindowsAutopilotInfo.ps1 -Online -Assign

    Write-Host "`n[SUCCES] De machine is succesvol aangemeld in de Intune portal." -ForegroundColor Green
}
catch {
    Write-Host "`n[FOUT] Er is een probleem opgetreden: $($_.Exception.Message)" -ForegroundColor Red
}
finally {
    Stop-Transcript
    Write-Host "==========================================================" -ForegroundColor Cyan
}