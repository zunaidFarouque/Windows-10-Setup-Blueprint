param(
    [switch]$SkipUrlConvert
)

# Set the source directory to the folder where this script is currently located (portable; no path hardcoding).
$sourceDir = $PSScriptRoot
$targetSubDir = "_My Shortcuts"    # CHANGE THIS to your desired Start Menu folder name

# Start Menu scope:
#   "CurrentUser" — %APPDATA%\Microsoft\Windows\Start Menu\Programs\...
#   "AllUsers"    — %ProgramData%\...\Programs\... (every account; script re-launches elevated via UAC when needed)
$StartMenuScope = "AllUsers"   # "CurrentUser" | "AllUsers"

# AllUsers (ProgramData) requires admin; re-launch this script elevated once if needed
if ($StartMenuScope -eq "AllUsers") {
    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
        [Security.Principal.WindowsBuiltinRole]::Administrator)
    if (-not $isAdmin) {
        if (-not $PSCommandPath) {
            throw "Cannot self-elevate: save this script as a .ps1 file and run it with -File (PSCommandPath is empty)."
        }
        Write-Host "Requesting administrator permission for All Users Start Menu (ProgramData)..." -ForegroundColor Yellow
        $hostExe = if ($PSVersionTable.PSEdition -eq "Core") { "pwsh.exe" } else { "powershell.exe" }
        $launchArgs = @(
            "-NoProfile",
            "-ExecutionPolicy", "Bypass",
            "-File", $PSCommandPath
        )
        if ($SkipUrlConvert) { $launchArgs += "-SkipUrlConvert" }
        Start-Process -FilePath (Join-Path $PSHOME $hostExe) -Verb RunAs -ArgumentList $launchArgs | Out-Null
        exit 0
    }
}

# Dynamically get the script's name so it won't copy itself, even if you rename it
$scriptName = if ($MyInvocation.MyCommand.Name) { $MyInvocation.MyCommand.Name } else { "Copy_Shortcuts_to_StartMenu.ps1" }

$programsRoot = switch ($StartMenuScope) {
    "AllUsers"    { [System.IO.Path]::Combine($env:ProgramData, "Microsoft\Windows\Start Menu\Programs") }
    "CurrentUser" { [System.IO.Path]::Combine($env:APPDATA, "Microsoft\Windows\Start Menu\Programs") }
    default       { throw "StartMenuScope must be 'CurrentUser' or 'AllUsers' (got: $StartMenuScope)." }
}
$startMenuPath = [System.IO.Path]::Combine($programsRoot, $targetSubDir)

# Create the specific subdirectory if it doesn't already exist
if (!(Test-Path -Path $startMenuPath)) {
    New-Item -ItemType Directory -Path $startMenuPath | Out-Null
    Write-Host "Created new Start Menu directory: $startMenuPath" -ForegroundColor Green
}

function Test-HasDontCopyPathSegment {
    param([string]$LiteralPath)
    if ([string]::IsNullOrWhiteSpace($LiteralPath)) { return $false }
    try {
        $norm = [System.IO.Path]::GetFullPath($LiteralPath)
    } catch {
        return $false
    }
    $seps = [char[]]@([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
    foreach ($seg in $norm.Split($seps, [StringSplitOptions]::RemoveEmptyEntries)) {
        if ([string]::Equals($seg, '_dont copy', [StringComparison]::OrdinalIgnoreCase)) {
            return $true
        }
    }
    return $false
}

# robocopy: exit codes 0-7 mean success (copied OK, no extra fatal errors)
function Sync-DirectoryExcludingDontCopy {
    param(
        [string]$SourceDir,
        [string]$DestDir
    )
    if (-not (Test-Path -LiteralPath $DestDir)) {
        New-Item -ItemType Directory -Path $DestDir -Force | Out-Null
    }
    $null = & robocopy.exe $SourceDir $DestDir /E /XD "_dont copy" /NFL /NDL /NJH /NJS /NC /NS /NP
    $code = $LASTEXITCODE
    if ($code -gt 7) {
        throw "robocopy failed (exit $code): $SourceDir -> $DestDir"
    }
}

# Regenerate .lnk from .url under Online\_dont copy (website icons, non-interactive)
$urlConverter = [System.IO.Path]::Combine($sourceDir, 'Online', '_dont copy', 'Convert-UrlFiles-ToLnk.ps1')
if (-not $SkipUrlConvert -and (Test-Path -LiteralPath $urlConverter)) {
    Write-Host "Running: Online\_dont copy\Convert-UrlFiles-ToLnk.ps1 (-NonInteractive)" -ForegroundColor Cyan
    $hostExe = Join-Path $PSHOME (if ($PSVersionTable.PSEdition -eq "Core") { "pwsh.exe" } else { "powershell.exe" })
    & $hostExe -NoProfile -ExecutionPolicy Bypass -File $urlConverter -NonInteractive
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Convert-UrlFiles-ToLnk.ps1 exited with code $LASTEXITCODE (continuing sync)."
    }
} elseif (-not $SkipUrlConvert) {
    Write-Host "Skipping URL convert (not found): $urlConverter" -ForegroundColor DarkGray
}

# Sync: top-level excludes this script and a root folder named "_dont copy".
# Any subfolder named "_dont copy" anywhere under a synced tree is excluded via robocopy /XD.
$skipNames = @($scriptName, '_dont copy')
Get-ChildItem -Path $sourceDir | Where-Object { $skipNames -notcontains $_.Name } | ForEach-Object {
    $destPath = [System.IO.Path]::Combine($startMenuPath, $_.Name)
    if ($_.PSIsContainer) {
        Sync-DirectoryExcludingDontCopy -SourceDir $_.FullName -DestDir $destPath
    } else {
        Copy-Item -LiteralPath $_.FullName -Destination $destPath -Force
    }
    Write-Host "Synced: $($_.Name)" -ForegroundColor Cyan
}

$scopeLabel = if ($StartMenuScope -eq "AllUsers") { "all users (ProgramData)" } else { "current user" }
Write-Host "Done ($scopeLabel). Check your Start Menu." -ForegroundColor Green

# AllUsers: list items under the Start Menu mirror folder that are not in the source tree; offer to delete them
if ($StartMenuScope -eq "AllUsers" -and (Test-Path -LiteralPath $startMenuPath)) {
    $sourceRoot = [System.IO.Path]::GetFullPath($sourceDir)
    $destRoot = [System.IO.Path]::GetFullPath($startMenuPath)

    $sourceRels = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    function Add-SourceTreeRel {
        param([string]$ItemPath)
        if (Test-HasDontCopyPathSegment -LiteralPath $ItemPath) { return }
        $rel = $ItemPath.Substring($sourceRoot.Length).TrimStart([char[]]@('\', '/'))
        [void]$sourceRels.Add($rel)
        if (Test-Path -LiteralPath $ItemPath -PathType Container) {
            Get-ChildItem -LiteralPath $ItemPath -Force | ForEach-Object { Add-SourceTreeRel $_.FullName }
        }
    }
    Get-ChildItem -LiteralPath $sourceRoot -Force | Where-Object { $skipNames -notcontains $_.Name } | ForEach-Object {
        Add-SourceTreeRel $_.FullName
    }

    $orphans = @(Get-ChildItem -LiteralPath $destRoot -Recurse -Force | Where-Object {
            $rel = $_.FullName.Substring($destRoot.Length).TrimStart([char[]]@('\', '/'))
            -not $sourceRels.Contains($rel)
        })

    if ($orphans.Count -gt 0) {
        Write-Host ""
        Write-Host "These paths exist under the Start Menu folder but not in your source tree (orphans / extras):" -ForegroundColor Yellow
        Write-Host "  Source: $sourceRoot" -ForegroundColor DarkGray
        Write-Host "  Start Menu folder: $destRoot" -ForegroundColor DarkGray
        foreach ($o in ($orphans | Sort-Object FullName)) {
            $display = $o.FullName.Substring($destRoot.Length).TrimStart([char[]]@('\', '/'))
            Write-Host "  $display" -ForegroundColor White
        }
        Write-Host ""
        $orphanAns = Read-Host "Remove these items from the Start Menu folder? [Y] Remove (default)  /  [n] Keep"
        $removeOrphans = ($orphanAns -ne "n" -and $orphanAns -ne "N")
        if ($removeOrphans) {
            foreach ($o in ($orphans | Sort-Object { $_.FullName.Length } -Descending)) {
                Remove-Item -LiteralPath $o.FullName -Force -Recurse -ErrorAction Continue
            }
            Write-Host "Removed orphan items." -ForegroundColor Green
        }
        else {
            Write-Host "Left unchanged." -ForegroundColor DarkGray
        }
    }
}

Write-Host ""
$iconAns = Read-Host "Clear icon cache and restart Explorer? [Y] Yes (default)  /  [n] No"
$rebuildIconCache = ($iconAns -ne "n" -and $iconAns -ne "N")
if ($rebuildIconCache) {
    Stop-Process -Name explorer -Force
    $cachePath = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\iconcache*"
    Remove-Item -Path $cachePath -Force -Recurse -ErrorAction SilentlyContinue
    Start-Process explorer
    Write-Host "Icon cache cleared." -ForegroundColor Green
}
