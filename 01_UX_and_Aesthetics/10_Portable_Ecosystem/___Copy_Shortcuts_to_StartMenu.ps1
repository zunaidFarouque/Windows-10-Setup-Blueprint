# Set the source directory to the folder where this script is currently located
$sourceDir = $PSScriptRoot 
$targetSubDir = "Scoop Custom Shortcuts"    # CHANGE THIS to your desired Start Menu folder name

# Dynamically get the script's name so it won't copy itself, even if you rename it
$scriptName = if ($MyInvocation.MyCommand.Name) { $MyInvocation.MyCommand.Name } else { "Copy_Shortcuts_to_StartMenu.ps1" }

# Build the path to the current user's Start Menu Programs folder
$startMenuPath = [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs", $targetSubDir)

# Create the specific subdirectory if it doesn't already exist
if (!(Test-Path -Path $startMenuPath)) {
    New-Item -ItemType Directory -Path $startMenuPath | Out-Null
    Write-Host "Created new Start Menu directory: $startMenuPath" -ForegroundColor Green
}

# Grab ALL items (files and folders) in the source directory, excluding the script itself
# -Recurse on Copy-Item ensures subfolders and their contents are copied intact
Get-ChildItem -Path $sourceDir -Exclude $scriptName | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $startMenuPath -Recurse -Force
    Write-Host "Synced: $($_.Name)" -ForegroundColor Cyan
}

Write-Host "Done. Check your Start Menu." -ForegroundColor Green

#######
# Refresh Thumbnail Cache
#######

# Stop Windows Explorer gracefully-ish
Stop-Process -Name explorer -Force

# Nuke the hidden icon cache databases in your local app data
$cachePath = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\iconcache*"
Remove-Item -Path $cachePath -Force -Recurse -ErrorAction SilentlyContinue

# Bring Explorer (and your taskbar) back to life
Start-Process explorer

Write-Host "Icon cache cleared." -ForegroundColor Green