param(
    [switch]$NonInteractive,
    [switch]$BrowserIconsOnly
)

# Folder layout (paths are resolved from this script's location; no drive/path hardcoding):
#   <Root>\                     — output .lnk shortcuts
#   <Root>\_dont copy\          — this script + input .url files
#   <Root>\_dont copy\_UrlShortcutIcons\ — favicon cache (created when using website icons)
#
# Converts every .url next to this script to a .lnk in <Root> with the same base name.
# PowerToys Command Palette indexes .lnk; it does not index .url.
# Icon: optional website favicon (cached under _UrlShortcutIcons), else default browser icon.

function Get-OpenCommandExePath {
    param([string]$CommandString)
    if ([string]::IsNullOrWhiteSpace($CommandString)) { return $null }
    $s = $CommandString.Trim()
    if ($s -match '^"([^"]+\.exe)"') { return $matches[1] }
    if ($s -match '^([A-Za-z]:[^"]*?\.exe)(?=\s|$)') { return $matches[1].TrimEnd() }
    if ($s -match '^(\S+\.exe)') { return $matches[1] }
    return $null
}

function Get-DefaultBrowserExecutable {
    foreach ($proto in @('http', 'https')) {
        $userChoice = "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\$proto\UserChoice"
        if (-not (Test-Path -LiteralPath $userChoice)) { continue }
        $progId = (Get-ItemProperty -LiteralPath $userChoice -ErrorAction SilentlyContinue).ProgId
        if ([string]::IsNullOrWhiteSpace($progId)) { continue }

        foreach ($openCmd in @(
            "Registry::HKEY_CLASSES_ROOT\$progId\shell\open\command",
            "Registry::HKEY_CURRENT_USER\Software\Classes\$progId\shell\open\command"
        )) {
            if (-not (Test-Path -LiteralPath $openCmd)) { continue }
            $raw = (Get-ItemProperty -LiteralPath $openCmd -ErrorAction SilentlyContinue).'(default)'
            $exe = Get-OpenCommandExePath $raw
            if ($exe -and (Test-Path -LiteralPath $exe)) { return $exe }
        }
    }
    return $null
}

function Test-IsIcoBytes {
    param([byte[]]$Bytes)
    return $Bytes -and $Bytes.Length -ge 6 -and $Bytes[0] -eq 0 -and $Bytes[1] -eq 0 -and $Bytes[2] -eq 1 -and $Bytes[3] -eq 0
}

function Test-IsPngBytes {
    param([byte[]]$Bytes)
    return $Bytes -and $Bytes.Length -ge 8 -and $Bytes[0] -eq 0x89 -and $Bytes[1] -eq 0x50 -and $Bytes[2] -eq 0x4E -and $Bytes[3] -eq 0x47
}

function Test-IsJpegBytes {
    param([byte[]]$Bytes)
    return $Bytes -and $Bytes.Length -ge 3 -and $Bytes[0] -eq 0xFF -and $Bytes[1] -eq 0xD8 -and $Bytes[2] -eq 0xFF
}

function Test-IsGifBytes {
    param([byte[]]$Bytes)
    return $Bytes -and $Bytes.Length -ge 6 -and
        $Bytes[0] -eq [byte][char]'G' -and $Bytes[1] -eq [byte][char]'I' -and $Bytes[2] -eq [byte][char]'F'
}

function Export-PngBytesAsIcoFile {
    param([byte[]]$PngBytes, [string]$IcoPath)
    if (-not (Test-IsPngBytes $PngBytes)) { return $false }
    if ($PngBytes.Length -lt 24) { return $false }

    $pw =
        ([uint32]$PngBytes[16] -shl 24) + ([uint32]$PngBytes[17] -shl 16) +
        ([uint32]$PngBytes[18] -shl 8) + [uint32]$PngBytes[19]
    $ph =
        ([uint32]$PngBytes[20] -shl 24) + ([uint32]$PngBytes[21] -shl 16) +
        ([uint32]$PngBytes[22] -shl 8) + [uint32]$PngBytes[23]

    $icoW = if ($pw -ge 256) { [byte]0 } else { [byte]$pw }
    $icoH = if ($ph -ge 256) { [byte]0 } else { [byte]$ph }

    $pngSize = [uint32]$PngBytes.Length
    $offset = [uint32]22
    $ms = New-Object System.IO.MemoryStream
    $ms.Write([byte[]]@(0, 0), 0, 2)
    $ms.Write([byte[]]@(1, 0), 0, 2)
    $ms.Write([byte[]]@(1, 0), 0, 2)
    $ms.Write([byte[]]@($icoW, $icoH, 0, 0), 0, 4)
    $ms.Write([byte[]]@(1, 0), 0, 2)
    $ms.Write([byte[]]@(0, 0), 0, 2)
    $ms.Write([System.BitConverter]::GetBytes($pngSize), 0, 4)
    $ms.Write([System.BitConverter]::GetBytes($offset), 0, 4)
    $ms.Write($PngBytes, 0, $PngBytes.Length)
    [System.IO.File]::WriteAllBytes($IcoPath, $ms.ToArray())
    return $true
}

function Save-RasterBytesAsIcoWithDrawing {
    param([byte[]]$Bytes, [string]$IcoPath)
    try {
        Add-Type -AssemblyName System.Drawing -ErrorAction Stop
    } catch {
        return $false
    }
    $ms = New-Object System.IO.MemoryStream(,$Bytes)
    try {
        $bmp = New-Object System.Drawing.Bitmap $ms
        try {
            $hIcon = $bmp.GetHicon()
            $icon = [System.Drawing.Icon]::FromHandle($hIcon)
            try {
                $fs = [System.IO.File]::Create($IcoPath)
                try { $icon.Save($fs) } finally { $fs.Dispose() }
            } finally {
                $icon.Dispose()
                [void][System.Drawing.Icon]::DestroyHandle($hIcon)
            }
        } finally {
            $bmp.Dispose()
        }
    } catch {
        return $false
    } finally {
        $ms.Dispose()
    }
    return (Test-Path -LiteralPath $IcoPath)
}

function Invoke-DownloadBytes {
    param([string]$UriStr)
    if ($UriStr -notmatch '^\s*https?://') { return $null }
    $wc = New-Object System.Net.WebClient
    $wc.Headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120 Safari/537.36'
    try {
        return $wc.DownloadData($UriStr.Trim())
    } catch {
        return $null
    } finally {
        $wc.Dispose()
    }
}

function Invoke-DownloadString {
    param([string]$UriStr)
    if ($UriStr -notmatch '^\s*https?://') { return $null }
    $wc = New-Object System.Net.WebClient
    $wc.Headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120 Safari/537.36'
    try {
        return $wc.DownloadString($UriStr.Trim())
    } catch {
        return $null
    } finally {
        $wc.Dispose()
    }
}

function Get-AttributeValue {
    param([string]$Tag, [string]$AttrName)
    $quoted = $AttrName + '\s*=\s*'
    if ($Tag -match ($quoted + '"([^"]*)"')) { return $matches[1] }
    if ($Tag -match ($quoted + "'([^']*)'")) { return $matches[1] }
    if ($Tag -match ($quoted + '([^\s>]+)')) { return $matches[1] }
    return $null
}

function Get-FaviconCandidateUris {
    param([uri]$PageUri, [string]$Html)
    $seen = @{}
    $out = [System.Collections.Generic.List[string]]::new()

    foreach ($m in [regex]::Matches($Html, '<link\b[^>]*>', 'IgnoreCase')) {
        $tag = $m.Value
        $rel = Get-AttributeValue -Tag $tag -AttrName 'rel'
        if (-not $rel -or $rel -notmatch 'icon|apple-touch') { continue }
        $href = Get-AttributeValue -Tag $tag -AttrName 'href'
        if (-not $href) { continue }
        if ($href -match '^(javascript|data):') { continue }
        try {
            $abs = ([uri]::new($PageUri, $href)).AbsoluteUri
            if (($abs -match '^https?://') -and (-not $seen.ContainsKey($abs))) {
                $seen[$abs] = $true
                $out.Add($abs)
            }
        } catch {}
    }

    try {
        $def = ([uri]::new($PageUri, '/favicon.ico')).AbsoluteUri
        if (-not $seen.ContainsKey($def)) { $out.Add($def) }
    } catch {}

    return $out
}

function Save-ImageBytesAsIco {
    param([byte[]]$Bytes, [string]$IcoPath)
    if (Test-IsIcoBytes $Bytes) {
        [System.IO.File]::WriteAllBytes($IcoPath, $Bytes)
        return $true
    }
    if (Test-IsPngBytes $Bytes) {
        return Export-PngBytesAsIcoFile -PngBytes $Bytes -IcoPath $IcoPath
    }
    if ((Test-IsJpegBytes $Bytes) -or (Test-IsGifBytes $Bytes)) {
        return Save-RasterBytesAsIcoWithDrawing -Bytes $Bytes -IcoPath $IcoPath
    }
    return $false
}

function Get-CachedFaviconIcoPath {
    param(
        [string]$TargetUrl,
        [string]$IconsDir
    )
    try {
        $pageUri = [uri]$TargetUrl
    } catch {
        return $null
    }
    if ($pageUri.Scheme -notin 'http', 'https') { return $null }

    $sha1 = [System.Security.Cryptography.SHA1]::Create()
    try {
        $hash = [System.BitConverter]::ToString($sha1.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($TargetUrl))) -replace '-', ''
    } finally {
        $sha1.Dispose()
    }

    $icoPath = [System.IO.Path]::Combine($IconsDir, "$hash.ico")
    if ((Test-Path -LiteralPath $icoPath) -and ((Get-Item -LiteralPath $icoPath).Length -gt 0)) {
        return $icoPath
    }

    $candidates = [System.Collections.Generic.List[string]]::new()
    $html = Invoke-DownloadString -UriStr $pageUri.AbsoluteUri
    if ($html) {
        foreach ($u in (Get-FaviconCandidateUris -PageUri $pageUri -Html $html)) {
            if (-not $candidates.Contains($u)) { $candidates.Add($u) }
        }
    }
    try {
        $fallback = ([uri]::new($pageUri, '/favicon.ico')).AbsoluteUri
        if (-not $candidates.Contains($fallback)) { $candidates.Add($fallback) }
    } catch {}

    foreach ($u in $candidates) {
        $bytes = Invoke-DownloadBytes -UriStr $u
        if (-not $bytes -or $bytes.Length -lt 4) { continue }
        if (Save-ImageBytesAsIco -Bytes $bytes -IcoPath $icoPath) {
            return $icoPath
        }
        if (Test-Path -LiteralPath $icoPath) { Remove-Item -LiteralPath $icoPath -Force -ErrorAction SilentlyContinue }
    }

    return $null
}

$inputRoot = $PSScriptRoot
if (-not $inputRoot) {
    throw "Run this script with -File so PSScriptRoot is set (e.g. powershell -File .\Convert-UrlFiles-ToLnk.ps1)."
}

$outputRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($inputRoot, '..'))
if (-not (Test-Path -LiteralPath $outputRoot)) {
    throw "Could not resolve Root (parent of this script folder). Put this script inside _dont copy under Root."
}

$urlFiles = Get-ChildItem -LiteralPath $inputRoot -Filter *.url -File
if ($urlFiles.Count -eq 0) {
    Write-Host "No .url files in: $inputRoot"
    exit 0
}

if ($NonInteractive) {
    $useWebsiteIcon = -not $BrowserIconsOnly
} else {
    Write-Host ""
    Write-Host "Shortcut icon source:"
    Write-Host "  [Y] Website icon - download favicon into a subfolder when possible (default)"
    Write-Host "  [N] Default browser icon only"
    $choice = Read-Host "Choice [Y/n]"
    $useWebsiteIcon = ($null -eq $choice -or $choice -eq '' -or $choice -match '^[Yy]')
}

$iconsDir = [System.IO.Path]::Combine($inputRoot, '_UrlShortcutIcons')
if ($useWebsiteIcon) {
    if (-not (Test-Path -LiteralPath $iconsDir)) {
        New-Item -ItemType Directory -Path $iconsDir | Out-Null
        Write-Host "Created icon cache folder: $iconsDir"
    }
}

$browserExe = Get-DefaultBrowserExecutable
if (-not $browserExe) {
    Write-Warning "Could not resolve default browser from registry; .lnk icons may look generic if website icon fails."
}

$shell = New-Object -ComObject WScript.Shell

foreach ($f in $urlFiles) {
    $text = Get-Content -LiteralPath $f.FullName -Raw -ErrorAction Stop
    if ($text -notmatch '(?m)^\s*URL\s*=\s*(.+)\s*$') {
        Write-Warning "Skipping (no URL= line): $($f.Name)"
        continue
    }

    $targetUrl = $matches[1].Trim()
    if ([string]::IsNullOrWhiteSpace($targetUrl)) {
        Write-Warning "Skipping (empty URL): $($f.Name)"
        continue
    }

    $lnkPath = [System.IO.Path]::Combine($outputRoot, $f.BaseName + '.lnk')
    $sc = $shell.CreateShortcut($lnkPath)
    $sc.TargetPath = $targetUrl
    $sc.Description = $f.BaseName

    $iconSet = $false
    if ($useWebsiteIcon) {
        $ico = Get-CachedFaviconIcoPath -TargetUrl $targetUrl -IconsDir $iconsDir
        if ($ico) {
            $sc.IconLocation = "$ico,0"
            $iconSet = $true
        }
    }
    if (-not $iconSet -and $browserExe) {
        $sc.IconLocation = "$browserExe,0"
    }

    $sc.Save()
    Write-Host ('Created: ' + [System.IO.Path]::GetFileName($lnkPath))
}

[System.Runtime.InteropServices.Marshal]::ReleaseComObject($shell) | Out-Null
