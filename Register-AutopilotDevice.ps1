<#
.SYNOPSIS
    Registreert de huidige machine in Windows Autopilot en logt het proces.
    
.NOTES
    Script gemaakt door: Alexander Zoutenbier
    Functie: Solution Architect SPEYK
<<<<<<< HEAD
    Datum: 05-03-2026

.DESCRIPTION
    1. Maakt C:\Temp aan als deze niet bestaat.
    2. Installeert het Get-WindowsAutopilotInfo script.
    3. Uploadt de Hardware Hash naar de Intune tenant.
    4. Logt de volledige sessie naar C:\Temp\AutopilotRegistration.log.
#>

=======

.DESCRIPTION
    Overschrijft ExecutionPolicy en uploadt de hardware hash naar Intune.
#>

# 1. Omgeving voorbereiden
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
>>>>>>> bc7cc84e85e312b1c67951eb8eb976b353372df4
$LogPath = "C:\Temp"
$LogFile = Join-Path $LogPath "AutopilotRegistration.log"
$ErrorActionPreference = "Stop"

<<<<<<< HEAD
# Zorg dat de logmap bestaat
if (-not (Test-Path $LogPath)) {
    try {
        New-Item -ItemType Directory -Path $LogPath -Force | Out-Null
    } catch {
        Write-Error "Kon de map $LogPath niet aanmaken. Controleer rechten."
        return
    }
}

# Start logging van de gehele sessie
=======
if (-not (Test-Path $LogPath)) {
    try { New-Item -ItemType Directory -Path $LogPath -Force | Out-Null } catch { }
}

>>>>>>> bc7cc84e85e312b1c67951eb8eb976b353372df4
Start-Transcript -Path $LogFile -Append

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  Autopilot Registratie Script" -ForegroundColor Cyan
Write-Host "  Gemaakt door: Alexander Zoutenbier (SPEYK)" -ForegroundColor White
Write-Host "==========================================================" -ForegroundColor Cyan

try {
<<<<<<< HEAD
    # Stap 1: NuGet provider installeren/updaten
    Write-Host "[1/3] NuGet provider configureren..." -ForegroundColor Gray
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null

    # Stap 2: Get-WindowsAutopilotInfo script ophalen
    Write-Host "[2/3] Autopilot tools downloaden uit de Gallery..." -ForegroundColor Gray
    Install-Script -Name Get-WindowsAutopilotInfo -Force -Confirm:$false

    # Stap 3: Registratie uitvoeren
    Write-Host "[3/3] Starten van hardware hash upload. Log in bij de Microsoft prompt..." -ForegroundColor Yellow
    
    # Parameters: 
    # -Online (Directe API connectie)
    # -Assign (Wacht op profiel toewijzing in Intune)
    # -AddEventListener (Geeft gedetailleerde status van de Graph API)
    Get-WindowsAutopilotInfo.ps1 -Online -Assign -AddEventListener
=======
    Write-Host "[1/3] NuGet provider configureren..." -ForegroundColor Gray
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null

    Write-Host "[2/3] Autopilot tools downloaden uit de Gallery..." -ForegroundColor Gray
    Install-Script -Name Get-WindowsAutopilotInfo -Force -Confirm:$false

    Write-Host "[3/3] Starten van hardware hash upload. Log in bij de Microsoft prompt..." -ForegroundColor Yellow
    
    # We hebben -AddEventListener verwijderd om compatibiliteitsproblemen te voorkomen
    Get-WindowsAutopilotInfo.ps1 -Online -Assign
>>>>>>> bc7cc84e85e312b1c67951eb8eb976b353372df4

    Write-Host "`n[SUCCES] De machine is succesvol aangemeld in de Intune portal." -ForegroundColor Green
}
catch {
<<<<<<< HEAD
    Write-Host "`n[FOUT] Er is een probleem opgetreden tijdens de registratie." -ForegroundColor Red
    Write-Host "Foutmelding: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Raadpleeg het logboek voor meer details: $LogFile" -ForegroundColor Yellow
}
finally {
    Stop-Transcript
    Write-Host "Proces beëindigd." -ForegroundColor Cyan
=======
    Write-Host "`n[FOUT] Er is een probleem opgetreden: $($_.Exception.Message)" -ForegroundColor Red
}
finally {
    Stop-Transcript
    Write-Host "==========================================================" -ForegroundColor Cyan
>>>>>>> bc7cc84e85e312b1c67951eb8eb976b353372df4
}