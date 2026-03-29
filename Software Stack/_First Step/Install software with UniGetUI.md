# Install software with UniGetUI

This note describes how to install and use [UniGetUI](https://github.com/Devolutions/UniGetUI): a single graphical interface for common Windows package sources (WinGet, Scoop, Chocolatey, Pip, Npm, .NET Tool, PowerShell Gallery, and others). Upstream overview and install options are in the [project README](https://github.com/Devolutions/UniGetUI/blob/main/README.md).

## Install UniGetUI

Pick one path; the WinGet route is convenient on a fresh Windows 10/11 install if WinGet is already working.

### GitHub release (installer or portable)

1. Open **[UniGetUI releases (latest)](https://github.com/Devolutions/UniGetUI/releases/latest)**.
2. Download **`UniGetUI.Installer.exe`** for a normal setup, or **`UniGetUI.x64.zip`** if you want a portable layout (see the release assets list for your machine).
3. Run the installer or extract the zip and start the app. Prefer verifying checksums when the release notes publish them (example from a recent release: SHA256 values listed on the release page for those assets).

## After install

1. **First launch:** Complete any onboarding or “enable package managers” steps in Settings so WinGet (and others you use) are detected. Install or repair [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/) if WinGet-backed installs fail.
2. **Discover / install:** Use search and filters, check publisher and source, then install or update packages. UniGetUI can **bulk** install, update, or uninstall from the list views.
3. **Updates:** You can enable notifications or automatic updates per package; the system tray entry summarizes pending updates on typical setups.
4. **Moving to another PC:** UniGetUI supports **exporting and importing** package lists (including custom install parameters in many cases)—use that for repeatable setups. That format is **not** the same as this repo’s WinUtil JSON (`Software Stack/Configs/Basic Software Installs.json`); use WinUtil import for WinUtil, and UniGetUI’s own export/import for UniGetUI.

### Optional: Install Scoop (no admin required)

Open a **non-administrator PowerShell** window and run:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

This installs [Scoop](https://scoop.sh), a versatile Windows package manager, for your user account only.

## Relation to this blueprint

- **WinUtil** (`Install software with winUtil.md`) is geared to one-shot Windows setup, tweaks, and its own package ID JSON.
- **UniGetUI** is better for **day-to-day** browsing, updates, and multi-manager installs without living entirely in PowerShell.

You can use both; just avoid assuming one tool’s saved list opens cleanly in the other.

# Things to install using UniGetUI

## Default

- Cloudflare warp
- Faststone Image Viewer
- Avro Keyboard
- stardesk
- Everything
- MPC BE
- WinRAR
- Notepad++
- TeraCopy
- FastCopy

## System

- ContextMenuManager
- Easy context menu
- Custom Resolution Utility

## UI

- Rainmeter ([Guide for my Setup](../../docs/Rainmeter/Rainmeter.md))

## Maintenance

- Krokiet - Data cleaner & Deduper
- RegistryFinder

## Image

- Affinity (Canva.Affinity)
- digikam
- Upscayl

## Video

- Shutter Encoder
- Videomass

## Musical, ASIO and MIDI:

- Voicemeeter
- LatencyMon
- ASIO4ALL
- FlexASIO
- ! FlexASIO GUI: https://github.com/flipswitchingmonkey/FlexASIO_GUI
- ! LoopMIDI: https://www.tobias-erichsen.de/software/loopmidi.html
