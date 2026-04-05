# Install software (UniGetUI + System) — fast runbook

Run this after WinUtil: [01 Install software with WinUtil.md](01_Install_software_with_WinUtil.md)

<details>
  <summary>
  <strong> First-Run Setup </strong>
  </summary>

## First-Run Setup

Open UniGetUI Settings and make sure WinGet, Chocolatey, and Scoop are installed and enabled as sources.

1. Setup Scoop with powershell (change the destination directory if needed):

   ```
   # Set the directory for Scoop portable apps
   $env:SCOOP='D:\_installed\scoop'
   [Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')

   # Install Scoop package manager
   Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

   # Install scoop-search for improved search capabilities
   scoop bucket known
   scoop install main/scoop-search
   if (!(Test-Path $PROFILE)) { New-Item -Type File -Path $PROFILE -Force }; notepad $PROFILE
   ```

2. When Notepad opens, paste the following line and save:

   ```
   . ([ScriptBlock]::Create((& scoop-search --hook | Out-String)))
   ```

   Then, load the profile and add buckets:

   ```
   . $PROFILE
   scoop bucket add third https://github.com/cmontage/scoopbucket-third
   scoop bucket add lemon https://github.com/hoilc/scoop-lemon
   scoop bucket add dodorz https://github.com/dodorz/scoop
   scoop bucket add ACooper81 https://github.com/ACooper81/scoop-apps
   scoop bucket add rivy https://github.com/rivy/scoop-bucket
   scoop bucket add scoop_UGU https://github.com/p8rdev/scoop-scoop_UGU
   scoop bucket add DEV-tools https://github.com/anderlli0053/DEV-tools
   scoop bucket add SCrispy https://github.com/Koalhack/SCrispyBucket
   scoop bucket add 257-notPublic https://github.com/gdm257/scoop-257
   scoop bucket add ZunaidScoop https://github.com/zunaidFarouque/Zunaid-Scoop-Bucket

   scoop install main/7zip main/innounp main/dark
   ```

</details>

## Reconnect Existing Setup (After OS Reinstall)

If you reinstalled Windows but your `D:\_installed\scoop` folder is still intact, **do not** run the First-Run Setup. Run this sequence to resurrect your apps, rebuild your Start Menu shortcuts, and restore your system variables without redownloading anything.

Open PowerShell and run this full reconnect sequence in one session:

```powershell
# Allow PowerShell scripts
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Point Windows to your existing Scoop folder
$env:SCOOP='D:\_installed\scoop'
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')

# Reinstall Scoop so the command is available again
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# Inject Scoop into your system PATH
$userPath = [Environment]::GetEnvironmentVariable('PATH', 'User')
if ($userPath -notmatch 'D:\\_installed\\scoop\\shims') {
    $newPath = "$userPath;D:\_installed\scoop\shims"
    [Environment]::SetEnvironmentVariable('PATH', $newPath, 'User')
    $env:PATH = "$env:PATH;D:\_installed\scoop\shims"
}

# Rebuild all application shims and Windows shortcuts
scoop reset *

# Reinstall scoop-search only if the preserved copy is not working
if (-not (Get-Command scoop-search -ErrorAction SilentlyContinue)) {
    scoop install main/scoop-search
}

# Recreate the PowerShell profile and inject the fast-search hook
if (!(Test-Path $PROFILE)) { New-Item -Type File -Path $PROFILE -Force }
Add-Content -Path $PROFILE -Value '. ([ScriptBlock]::Create((& scoop-search --hook | Out-String)))'
. $PROFILE
```

# UniGetUI Bundles for Quick Start

Quickly import baseline environments in UniGetUI using these curated bundles:

- [Absolute Core.ubundle](02_UniGetUI_Bundles/Absolute%20Core.ubundle)
- [Secondary Core.ubundle](02_UniGetUI_Bundles/Secondary%20Core.ubundle)

These bundles cover the non-runtime app set for quick start.

The core runtime items still need manual installation:

- [VC++ Redistributables (AIO)](https://github.com/abbodi1406/vcredist/releases)
- [DirectX End-User Runtimes (Jun 2010)](https://www.microsoft.com/en-us/download/details.aspx?id=8109)
- [.NET Desktop Runtime (latest)](https://dotnet.microsoft.com/en-us/download/dotnet/latest/runtime)
- [IObit Driver Booster](https://www.iobit.com/en/driver-booster.php)

Extra Manual-install assets are: [`03_Manual_Install/installme.rar`](../03_Manual_Install/installme.rar), [`03_Manual_Install/installme2.rar`](../03_Manual_Install/installme2.rar).

Windhawk backup assets: [`11_Windhawk/Windhawk_Latest_Backup.zip`](11_Windhawk/Windhawk_Latest_Backup.zip); and a guide on how to backup/restore: [`11_Windhawk/windhawk.md`](11_Windhawk/windhawk.md), .

If bundle import does not work, use the detailed list below to install items individually.

# Things to install (UniGetUI + manual system tools)

| Software                                  | Install Method                                                              | What it does / Why I need it                               |
| ----------------------------------------- | --------------------------------------------------------------------------- | ---------------------------------------------------------- |
| **_🔶 Core runtimes / deps_**             |                                                                             |                                                            |
| **VC++ Redistributables (AIO)**           | [Manual](https://github.com/abbodi1406/vcredist/releases)                   | One-shot install of common VC++ runtimes.                  |
| **DirectX End-User Runtimes (Jun 2010)**  | [Manual](https://www.microsoft.com/en-us/download/details.aspx?id=8109)     | Legacy DirectX components for older apps/games.            |
| **.NET Desktop Runtime (latest)**         | [Manual](https://dotnet.microsoft.com/en-us/download/dotnet/latest/runtime) | Required by many modern Windows desktop apps.              |
| **IObit Driver Booster**                  | [Manual (D)](https://www.iobit.com/en/driver-booster.php)                   | Quick driver + “game components” install.                  |
| **_🔶 Core defaults_**                    |                                                                             |                                                            |
| **Cloudflare WARP**                       | UniGetUI                                                                    | VPN/DNS for blocked/bad networks.                          |
| **Avro Keyboard**                         | UniGetUI                                                                    | Bangla typing.                                             |
| **Everything**                            | UniGetUI                                                                    | Instant file search.                                       |
| **WinRAR**                                | UniGetUI                                                                    | Archive tool (RAR/ZIP/etc).                                |
| **Notepad++**                             | UniGetUI                                                                    | Lightweight editor for ops work.                           |
| **TeraCopy**                              | UniGetUI                                                                    | Better copy/move with retries and queue.                   |
| **Bulk Crap Uninstaller (BCUninstaller)** | UniGetUI                                                                    | Bulk uninstall apps and remove leftovers fast.             |
| **_🔶 Media_**                            |                                                                             |                                                            |
| **FastStone Image Viewer**                | UniGetUI                                                                    | Fast local image viewer for quick triage.                  |
| **MPC-BE**                                | UniGetUI                                                                    | Lean media player.                                         |
| **VLC**                                   | UniGetUI                                                                    | Backup player for odd formats/streams.                     |
| **FFmpeg**                                | UniGetUI                                                                    | CLI media swiss-army knife.                                |
| **K-Lite Codec Pack**                     | UniGetUI                                                                    | Wide codec support.                                        |
| **LAV Filters**                           | UniGetUI                                                                    | Decoder/filter stack for players.                          |
| **Icaros**                                | UniGetUI                                                                    | Adds thumbnails and shell previews for more media formats. |
| **CopyTrans HEIC**                        | [Manual](https://www.copytrans.net/copytransheic/)                          | HEIC/HEIF support in Windows Explorer/apps.                |
| **_🔶 Display & shell_**                  |                                                                             |                                                            |
| **EarTrumpet**                            | UniGetUI                                                                    | Per-app audio control.                                     |
| [Windhawk](11_Windhawk/windhawk.md)       | UniGetUI                                                                    | Windows UI tweaks via mods.                                |

---

# Next steps

You are now ready for [Optimizations & tweaks](03_optimizations_and_tweaks.md) — continue setup to apply recommended system optimizations and privacy tweaks.
