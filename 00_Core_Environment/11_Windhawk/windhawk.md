# Windhawk Setup

## Why Windhawk?

Windhawk replaces the need for messy, permanent registry hacks or obscure tweakers. It acts as a transparent, open-source marketplace that safely injects mods into Windows processes in real-time. If something breaks, simply disabling the mod safely reverts the system behavior immediately.

## 📤 How to Backup

Run `backup_windhawk.ps1` as Administrator.
The script creates a new timestamped `backup_*` folder in this directory, then packages that folder together with `backup_windhawk.ps1` and `restore_windhawk.ps1` into `Windhawk_Latest_Backup.zip`.
For long-term backup, keep the `Windhawk_Latest_Backup.zip` file.

## 📥 How to Restore

1. Install the Windhawk application on the fresh Windows setup.
2. Extract [`Windhawk_Latest_Backup.zip`](./Windhawk_Latest_Backup.zip) into any folder.
3. Run `restore_windhawk.ps1` as Administrator.
   The script automatically restores from the newest `backup_*` folder next to it, imports the saved registry settings, copies `ModsSource`, and restarts the Windhawk service.


## Current list of mods that I use and why

### Taskbar

- **Click on empty taskbar space** (`taskbar-empty-space-clicks`) — Bind custom actions to clicks on empty taskbar space.
  - Settings: Left-button **triple-click** → open Task Manager; **mouse side button 1** click → Win+Tab.
- **Middle click to close on the taskbar** (`taskbar-button-click`) — Middle-click a taskbar button to close the program instead of opening a new instance.
- **Open pinned items with double click** (`pinned-items-double-click`) — Require a double-click to launch pinned items, preventing accidental single-click launches.
- **Taskbar Scroll Actions** (`taskbar-scroll-actions`) — Scroll over the taskbar to trigger actions like virtual desktop switching.
  - Settings: Scroll action = **Switch virtual desktop**; scroll area = **the taskbar without the tray area**.
- **Taskbar tray system icon tweaks** (`taskbar-tray-system-icon-tweaks`) — Hide individual system tray icons (volume, network, battery, etc.).
  - Settings: **Volume icon hidden** (using EarTrumpet for volume control instead).
- **Taskbar Volume Control** (`taskbar-volume-control`) — Scroll over the taskbar (or anywhere with a modifier) to change system volume.
- **Taskbar Labels for Windows 11** (`taskbar-labels`) — Restores labeled taskbar buttons and gives granular control over width, indicators, and label behavior for better multitasking readability.
  - Settings: Mode = **Show labels, don't combine taskbar buttons**; item width tuned (140, min 50, max 176); indicator style = **Centered, dynamic size**; progress style = **Full width**; trim long text with ellipsis.
- **Taskbar height and icon size** (`taskbar-icon-size`) — Set taskbar height and icon size explicitly so the bar can be shorter and icons stay crisp instead of blurry downscaling (Windows 11 only).
  - Settings: Taskbar height **36** (default 48); icon size **18** (default 24); taskbar button width **36** (default 44).

### File Explorer

- **Better file sizes in Explorer details** (`explorer-details-better-file-sizes`) — Show folder sizes in Details view and use MB/GB (and IEC units) instead of always-KB.
  - Settings: **Show folder sizes via "Everything" integration** (requires Everything installed with *Index file size* and *Index folder size* enabled, and Everything running).
- **Explorer Double Click Up** (`explorer-double-click-up`) — Double-click empty space in Explorer to navigate up one folder.

### Windows & Virtual Desktops

- **Alt+Tab per monitor** (`alt-tab-per-monitor`) — Make Alt+Tab show only the windows on the monitor where the cursor is, instead of always the primary display.
- **Disable Virtual Desktop Transition Animation** (`disable-virtual-desktop-transition`) — Remove the slide animation when switching virtual desktops so switches feel instant.
