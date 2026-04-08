# Ensure the script is running with Administrator privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERROR: You must run this script as Administrator." -ForegroundColor Red
    Pause
    Exit
}

$sourceDll = ".\acpimof.dll"
$destinationDir = "C:\Windows\SysWOW64"
$destinationDll = "$destinationDir\acpimof.dll"
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\WmiAcpi"

# Verify the DLL is present in the working directory
if (-Not (Test-Path $sourceDll)) {
    Write-Host "ERROR: acpimof.dll not found!" -ForegroundColor Red
    Write-Host "Make sure this script is in the exact same folder as the extracted acpimof.dll file." -ForegroundColor Yellow
    Pause
    Exit
}

# 1. Copy the DLL to the system directory
Write-Host "[1/3] Copying acpimof.dll to $destinationDir..." -ForegroundColor Cyan
Copy-Item -Path $sourceDll -Destination $destinationDll -Force

# 2. Map the Registry Key
Write-Host "[2/3] Writing MofImagePath to Registry ($regPath)..." -ForegroundColor Cyan
if (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}
Set-ItemProperty -Path $regPath -Name "MofImagePath" -Value $destinationDll -Type String -Force

# 3. Prompt for the required kernel reboot
Write-Host "[3/3] Injection successful!" -ForegroundColor Green
Write-Host "The system MUST reboot to load the WMI driver into the kernel." -ForegroundColor Yellow
$restart = Read-Host "Do you want to restart now? (Y/N)"
if ($restart -match "^[yY]$") {
    Restart-Computer -Force
} else {
    Write-Host "Please remember to restart manually before attempting to run the fan control installation." -ForegroundColor Yellow
}