# Install software (UniGetUI + System) — fast runbook

Run this after WinUtil: [01 Install software with WinUtil.md](01_Install_software_with_WinUtil.md)

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
   scoop install main/7zip main/innounp main/dark
   ```

# Things to install (UniGetUI + manual system tools)

| Software                                  | Install Method                                                              | What it does / Why I need it                    |
| ----------------------------------------- | --------------------------------------------------------------------------- | ----------------------------------------------- |
| **_🔶 Core defaults_**                    |                                                                             |                                                 |
| **Cloudflare WARP**                       | UniGetUI                                                                    | VPN/DNS for blocked/bad networks.               |
| **Avro Keyboard**                         | UniGetUI                                                                    | Bangla typing.                                  |
| **Everything**                            | UniGetUI                                                                    | Instant file search.                            |
| **WinRAR**                                | UniGetUI                                                                    | Archive tool (RAR/ZIP/etc).                     |
| **Notepad++**                             | UniGetUI                                                                    | Lightweight editor for ops work.                |
| **TeraCopy**                              | UniGetUI                                                                    | Better copy/move with retries and queue.        |
| **Bulk Crap Uninstaller (BCUninstaller)** | UniGetUI                                                                    | Bulk uninstall apps and remove leftovers fast.  |
| **_🔶 Media_**                            |                                                                             |                                                 |
| **FastStone Image Viewer**                | UniGetUI                                                                    | Fast local image viewer for quick triage.       |
| **MPC-BE**                                | UniGetUI                                                                    | Lean media player.                              |
| **VLC**                                   | UniGetUI                                                                    | Backup player for odd formats/streams.          |
| **FFmpeg**                                | UniGetUI                                                                    | CLI media swiss-army knife.                     |
| **K-Lite Codec Pack**                     | UniGetUI                                                                    | Wide codec support.                             |
| **LAV Filters**                           | UniGetUI                                                                    | Decoder/filter stack for players.               |
| **Icaros**                                | UniGetUI                                                                    | Adds thumbnails and shell previews for more media formats. |
| **CopyTrans HEIC**                        | [Manual](https://www.copytrans.net/copytransheic/)                          | HEIC/HEIF support in Windows Explorer/apps.     |
| **_🔶 Display & shell_**                  |                                                                             |                                                 |
| **EarTrumpet**                            | UniGetUI                                                                    | Per-app audio control.                          |
| [Windhawk](11_Windhawk/windhawk.md)       | UniGetUI                                                                    | Windows UI tweaks via mods.                     |
| **_🔶 Core runtimes / deps_**             |                                                                             |                                                 |
| **VC++ Redistributables (AIO)**           | [Manual](https://github.com/abbodi1406/vcredist/releases)                   | One-shot install of common VC++ runtimes.       |
| **DirectX End-User Runtimes (Jun 2010)**  | [Manual](https://www.microsoft.com/en-us/download/details.aspx?id=8109)     | Legacy DirectX components for older apps/games. |
| **.NET Desktop Runtime (latest)**         | [Manual](https://dotnet.microsoft.com/en-us/download/dotnet/latest/runtime) | Required by many modern Windows desktop apps.   |
| **IObit Driver Booster**                  | [Manual (D)](https://www.iobit.com/en/driver-booster.php)                   | Quick driver + “game components” install.       |
