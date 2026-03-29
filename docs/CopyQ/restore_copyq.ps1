# restore_copyq.ps1
$repoConfigDir = "$PSScriptRoot\config-files"
$copyqAppdata = "$env:APPDATA\copyq"

Write-Host "Restoring essential CopyQ configurations..." -ForegroundColor Cyan

function Wait-CopyQExited {
    param([int]$TimeoutSec = 45)
    $deadline = (Get-Date).AddSeconds($TimeoutSec)
    while (Get-Process -Name "copyq" -ErrorAction SilentlyContinue) {
        if ((Get-Date) -gt $deadline) {
            throw "CopyQ did not exit within ${TimeoutSec}s. Exit from the tray (Exit), then run this script again."
        }
        Start-Sleep -Milliseconds 400
    }
}

# Ask CopyQ to exit gracefully if CLI is available (closing the window is not enough)
$copyqCmd = Get-Command copyq -ErrorAction SilentlyContinue
if ($copyqCmd) {
    try {
        & copyq exit 2>$null
    } catch {
        # Ignore; we still force-stop below.
    }
}

Get-Process -Name "copyq" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Wait-CopyQExited

# Fresh-install files conflict with restored tab/settings INIs (see CopyQ backup docs: replace the whole config dir).
Remove-Item -LiteralPath $copyqAppdata -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $copyqAppdata | Out-Null

# List of specific files to restore
$filesToRestore = @(
    "copyq.ini",
    "copyq-commands.ini",
    "copyq_tabs.ini",
    "copyq-scripts.ini"
)

foreach ($file in $filesToRestore) {
    $sourcePath = Join-Path $repoConfigDir $file
    if (Test-Path -LiteralPath $sourcePath) {
        Copy-Item -LiteralPath $sourcePath -Destination (Join-Path $copyqAppdata $file) -Force
        Write-Host "Restored: $file" -ForegroundColor Gray
    } else {
        Write-Host "Skipped (not in repo): $file" -ForegroundColor Yellow
    }
}

# Clipboard tab data lives under items\; restore when your backup includes it (optional).
$repoItems = Join-Path $repoConfigDir "items"
if (Test-Path -LiteralPath $repoItems) {
    Copy-Item -LiteralPath $repoItems -Destination (Join-Path $copyqAppdata "items") -Recurse -Force
    Write-Host "Restored: items\" -ForegroundColor Gray
}

Write-Host "CopyQ restore complete! You can now launch CopyQ." -ForegroundColor Green