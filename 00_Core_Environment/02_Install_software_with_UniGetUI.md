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
   scoop bucket add main https://github.com/ScoopInstaller/Main.git
   scoop bucket add extras https://github.com/ScoopInstaller/Extras
   scoop bucket add nirsoft https://github.com/ScoopInstaller/Nirsoft
   scoop bucket add sysinternals https://github.com/niheaven/scoop-sysinternals
   scoop bucket add 257-notPublic https://github.com/gdm257/scoop-257
   scoop bucket add DEV-tools https://github.com/anderlli0053/DEV-tools
   scoop bucket add dodorz https://github.com/dodorz/scoop
   scoop bucket add lemon https://github.com/hoilc/scoop-lemon
   scoop bucket add portableApps https://github.com/p8rdev/scoop-portableapps
   scoop bucket add SCrispy https://github.com/Koalhack/SCrispyBucket
   scoop bucket add third https://github.com/cmontage/scoopbucket-third
   scoop bucket add Zuanid-Scoop https://github.com/zunaidFarouque/Zunaid-Scoop-Bucket

   scoop install main/7zip main/innounp main/dark
   ```

</details>

## Reconnect Existing Setup (After OS Reinstall)

If `D:\_installed\scoop` already exists (after OS reinstall or when using a different Windows user), run this sequence.

1. Fix ownership/permissions first (existing Scoop + new Windows/user case):

   ```
   takeown /F "D:\_installed\scoop" /R /D Y
   icacls "D:\_installed\scoop" /setowner "%USERNAME%" /T
   ```

2. If Git still shows `detected dubious ownership` (unsafe directory), mark it as safe:

   ```
   git config --global --add safe.directory "D:/_installed/scoop/apps/scoop/current"
   ```

3. Remove previous buckets:

   ```
   scoop bucket rm main
   scoop bucket rm extras
   scoop bucket rm nirsoft
   scoop bucket rm sysinternals
   scoop bucket rm 257-notPublic
   scoop bucket rm DEV-tools
   scoop bucket rm dodorz
   scoop bucket rm lemon
   scoop bucket rm portableApps
   scoop bucket rm SCrispy
   scoop bucket rm third
   scoop bucket rm Zuanid-Scoop
   ```

4. Re-add buckets:

   ```
   scoop bucket add main https://github.com/ScoopInstaller/Main.git
   scoop bucket add extras https://github.com/ScoopInstaller/Extras
   scoop bucket add nirsoft https://github.com/ScoopInstaller/Nirsoft
   scoop bucket add sysinternals https://github.com/niheaven/scoop-sysinternals
   scoop bucket add 257-notPublic https://github.com/gdm257/scoop-257
   scoop bucket add DEV-tools https://github.com/anderlli0053/DEV-tools
   scoop bucket add dodorz https://github.com/dodorz/scoop
   scoop bucket add lemon https://github.com/hoilc/scoop-lemon
   scoop bucket add portableApps https://github.com/p8rdev/scoop-portableapps
   scoop bucket add SCrispy https://github.com/Koalhack/SCrispyBucket
   scoop bucket add third https://github.com/cmontage/scoopbucket-third
   scoop bucket add Zuanid-Scoop https://github.com/zunaidFarouque/Zunaid-Scoop-Bucket
   ```

# UniGetUI Bundles for Quick Start

Quickly import baseline environments in UniGetUI using these curated bundles:

- [Absolute Core.ubundle](02_UniGetUI_Bundles/Absolute%20Core.ubundle)
- [Secondary Core.ubundle](02_UniGetUI_Bundles/Secondary%20Core.ubundle)

Windhawk backup assets: [`11_Windhawk/Windhawk_Latest_Backup.zip`](11_Windhawk/Windhawk_Latest_Backup.zip); and a guide on how to backup/restore: [`11_Windhawk/windhawk.md`](11_Windhawk/windhawk.md), .

If bundle import does not work, use the detailed list below to install items individually.

# Things to install (UniGetUI + manual system tools)

| Software                                       | Install Method                                     | What it does / Why I need it                               |
| ---------------------------------------------- | -------------------------------------------------- | ---------------------------------------------------------- |
| **_🔶 Core runtimes / deps_**                  |                                                    |                                                            |
| **Microsoft VC++ Redistributable 2015+ (x64)** | UniGetUI (`Microsoft.VCRedist.2015+.x64`)          | Core C++ runtime for many 64-bit apps/games.               |
| **Microsoft VC++ Redistributable 2015+ (x86)** | UniGetUI (`Microsoft.VCRedist.2015+.x86`)          | Core C++ runtime for many 32-bit apps/games.               |
| **Microsoft DirectX Runtime**                  | UniGetUI (`Microsoft.DirectX`)                     | Legacy DirectX components required by older software.      |
| **.NET Desktop Runtime 9**                     | UniGetUI (`Microsoft.DotNet.DesktopRuntime.9`)     | Required by modern .NET desktop applications.              |
| **Microsoft OpenAL**                           | UniGetUI (`Microsoft.OpenAL`)                      | 3D audio runtime used by some games and audio tools.       |
| **Microsoft XNA Redistributable**              | UniGetUI (`Microsoft.XNARedist`)                   | Runtime for older XNA-based games/apps.                    |
| **Creative OpenAL**                            | UniGetUI (`CreativeTechnology.OpenAL`)             | Alternative OpenAL runtime for compatibility.              |
| **_🔶 Core defaults_**                         |                                                    |                                                            |
| **Cloudflare WARP**                            | UniGetUI                                           | VPN/DNS for blocked/bad networks.                          |
| **Avro Keyboard**                              | UniGetUI                                           | Bangla typing.                                             |
| **PowerShell 7**                               | UniGetUI                                           | Modern shell for scripting and automation tasks.           |
| **Windows Terminal**                           | UniGetUI                                           | Tabbed terminal host for PowerShell, CMD, and WSL.         |
| **Everything**                                 | UniGetUI                                           | Instant file search.                                       |
| **WinRAR**                                     | UniGetUI                                           | Archive tool (RAR/ZIP/etc).                                |
| **Notepad++**                                  | UniGetUI                                           | Lightweight editor for ops work.                           |
| **TeraCopy**                                   | UniGetUI                                           | Better copy/move with retries and queue.                   |
| **Bulk Crap Uninstaller (BCUninstaller)**      | UniGetUI                                           | Bulk uninstall apps and remove leftovers fast.             |
| **_🔶 Media_**                                 |                                                    |                                                            |
| **FastStone Image Viewer**                     | UniGetUI                                           | Fast local image viewer for quick triage.                  |
| **MPC-BE**                                     | UniGetUI                                           | Lean media player.                                         |
| **VLC**                                        | UniGetUI                                           | Backup player for odd formats/streams.                     |
| **FFmpeg**                                     | UniGetUI                                           | CLI media swiss-army knife.                                |
| **K-Lite Codec Pack**                          | UniGetUI                                           | Wide codec support.                                        |
| **LAV Filters**                                | UniGetUI                                           | Decoder/filter stack for players.                          |
| **Icaros**                                     | UniGetUI                                           | Adds thumbnails and shell previews for more media formats. |
| **CopyTrans HEIC**                             | [Manual](https://www.copytrans.net/copytransheic/) | HEIC/HEIF support in Windows Explorer/apps.                |
| **_🔶 Display & shell_**                       |                                                    |                                                            |
| **EarTrumpet**                                 | UniGetUI                                           | Per-app audio control.                                     |
| [Windhawk](11_Windhawk/windhawk.md)            | UniGetUI                                           | Windows UI tweaks via mods.                                |

---

# Next steps

You are now ready for [Optimizations & tweaks](03_optimizations_and_tweaks.md) — continue setup to apply recommended system optimizations and privacy tweaks.
