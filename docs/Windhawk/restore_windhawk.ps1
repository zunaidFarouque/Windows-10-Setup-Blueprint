#Requires -RunAsAdministrator

$repoConfigDir = "$PSScriptRoot\..\config-files\windhawk"
$windhawkData = "$env:ProgramData\Windhawk"

Write-Host "Restoring Windhawk mods and settings..." -ForegroundColor Cyan

# 1. Stop Windhawk Service so files aren't locked
Write-Host "Stopping Windhawk service..." -ForegroundColor Gray
Stop-Service -Name "WindhawkService" -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# 2. Import Registry Settings
if (Test-Path "$repoConfigDir\windhawk_registry.reg") {
    reg import "$repoConfigDir\windhawk_registry.reg" | Out-Null
    Write-Host "Imported Registry Settings." -ForegroundColor Gray
}

# 3. Restore Mod Files and Source
$foldersToRestore = @("Engine\Mods", "ModsSource")

foreach ($folder in $foldersToRestore) {
    $sourcePath = "$repoConfigDir\$folder"
    if (Test-Path $sourcePath) {
        Copy-Item -Path $sourcePath -Destination "$windhawkData\$folder" -Recurse -Force
        Write-Host "Restored: $folder" -ForegroundColor Gray
    }
}

# 4. Restart Windhawk Service to apply mods
Write-Host "Restarting Windhawk service..." -ForegroundColor Gray
Start-Service -Name "WindhawkService" -ErrorAction SilentlyContinue

Write-Host "Windhawk restore complete!" -ForegroundColor Green