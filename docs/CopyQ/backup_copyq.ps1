# backup_copyq.ps1
$repoConfigDir = "$PSScriptRoot\config-files"
$copyqAppdata = "$env:APPDATA\copyq"

# Create the repo config directory if it doesn't exist
if (-not (Test-Path $repoConfigDir)) {
    New-Item -ItemType Directory -Force -Path $repoConfigDir | Out-Null
}

Write-Host "Backing up essential CopyQ configurations..." -ForegroundColor Cyan

# List of specific files to backup
$filesToBackup = @(
    "copyq.ini",
    "copyq-commands.ini",
    "copyq_tabs.ini",
    "copyq-scripts.ini"
)

foreach ($file in $filesToBackup) {
    $sourcePath = "$copyqAppdata\$file"
    if (Test-Path $sourcePath) {
        Copy-Item -Path $sourcePath -Destination "$repoConfigDir\$file" -Force
        Write-Host "Copied: $file" -ForegroundColor Gray
    } else {
        Write-Host "Skipped (Not Found): $file" -ForegroundColor Yellow
    }
}

Write-Host "CopyQ backup successfully saved to your local repository!" -ForegroundColor Green