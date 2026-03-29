#Requires -RunAsAdministrator

$repoConfigDir = "$PSScriptRoot\..\config-files\windhawk"
$windhawkData = "$env:ProgramData\Windhawk"

# Create the repo config directory if it doesn't exist
if (-not (Test-Path $repoConfigDir)) {
    New-Item -ItemType Directory -Force -Path $repoConfigDir | Out-Null
}

Write-Host "Backing up Windhawk mods and settings..." -ForegroundColor Cyan

# 1. Export Registry (Mod Settings & Enabled States)
reg export "HKLM\SOFTWARE\Windhawk" "$repoConfigDir\windhawk_registry.reg" /y | Out-Null
Write-Host "Exported Registry Settings." -ForegroundColor Gray

# 2. Backup Mod Files and Source
$foldersToBackup = @("Engine\Mods", "ModsSource")

foreach ($folder in $foldersToBackup) {
    $sourcePath = "$windhawkData\$folder"
    if (Test-Path $sourcePath) {
        # Copy-Item with -Recurse to grab all sub-files
        Copy-Item -Path $sourcePath -Destination "$repoConfigDir\$folder" -Recurse -Force
        Write-Host "Copied: $folder" -ForegroundColor Gray
    } else {
        Write-Host "Skipped (Not Found): $folder" -ForegroundColor Yellow
    }
}

Write-Host "Windhawk backup successfully saved to your local repository!" -ForegroundColor Green