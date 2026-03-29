# Install software with UniGetUI

This note describes how to install and use [UniGetUI](https://github.com/Devolutions/UniGetUI): a single graphical interface for common Windows package sources (WinGet, Scoop, Chocolatey, Pip, Npm, .NET Tool, PowerShell Gallery, and others). Upstream overview and install options are in the [project README](https://github.com/Devolutions/UniGetUI/blob/main/README.md).

## Official sources (avoid fakes)

Use only the [UniGetUI GitHub repository](https://github.com/Devolutions/UniGetUI), the [latest releases page](https://github.com/Devolutions/UniGetUI/releases/latest), or the product page linked from upstream: [devolutions.net/unigetui](https://devolutions.net/unigetui/). Other domains that mimic the name have been called out as **unofficial** in the project README—do not treat them as download sources.

## Install UniGetUI

Pick one path; the WinGet route is convenient on a fresh Windows 10/11 install if WinGet is already working.

### GitHub release (installer or portable)

1. Open **[UniGetUI releases (latest)](https://github.com/Devolutions/UniGetUI/releases/latest)**.
2. Download **`UniGetUI.Installer.exe`** for a normal setup, or **`UniGetUI.x64.zip`** if you want a portable layout (see the release assets list for your machine).
3. Run the installer or extract the zip and start the app. Prefer verifying checksums when the release notes publish them (example from a recent release: SHA256 values listed on the release page for those assets).

### WinGet

```cmd
winget install --exact --id Devolutions.UniGetUI --source winget
```

### Scoop

```cmd
scoop bucket add extras
scoop install extras/unigetui
```

### Chocolatey

```cmd
choco install wingetui
```

The Chocolatey package id may still use the historical name `wingetui`; confirm on [Chocolatey](https://community.chocolatey.org/packages/wingetui) if the command changes.

### Microsoft Store

The upstream README recommends the **Microsoft Store** route when that fits your environment; use Store search or the link from [devolutions.net/unigetui](https://devolutions.net/unigetui/) so you stay on a trusted channel.

## After install

1. **First launch:** Complete any onboarding or “enable package managers” steps in Settings so WinGet (and others you use) are detected. Install or repair [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/) if WinGet-backed installs fail.
2. **Discover / install:** Use search and filters, check publisher and source, then install or update packages. UniGetUI can **bulk** install, update, or uninstall from the list views.
3. **Updates:** You can enable notifications or automatic updates per package; the system tray entry summarizes pending updates on typical setups.
4. **Moving to another PC:** UniGetUI supports **exporting and importing** package lists (including custom install parameters in many cases)—use that for repeatable setups. That format is **not** the same as this repo’s WinUtil JSON (`Software Stack/Configs/Basic Software Installs.json`); use WinUtil import for WinUtil, and UniGetUI’s own export/import for UniGetUI.

## Relation to this blueprint

- **WinUtil** (`Install software with winUtil.md`) is geared to one-shot Windows setup, tweaks, and its own package ID JSON.
- **UniGetUI** is better for **day-to-day** browsing, updates, and multi-manager installs without living entirely in PowerShell.

You can use both; just avoid assuming one tool’s saved list opens cleanly in the other.

## Safety

Packages come from **third-party** catalogs. Prefer known publishers, read metadata before installing, and keep backups or a restore point before large batch installs or removals.
