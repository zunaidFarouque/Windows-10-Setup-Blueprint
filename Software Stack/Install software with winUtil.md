# Install software with WinUtil

This note describes how to run [Chris Titus Tech’s WinUtil](https://github.com/ChrisTitusTech/winutil), restore this repo’s saved install list from JSON, and apply the bundled O&O ShutUp10++ profile. Official usage and tabs are summarized in the [WinUtil documentation](https://winutil.christitus.com/).

## Run WinUtil

WinUtil changes system-wide settings and installers, so it must run **elevated**.

1. Open an **administrator** PowerShell session (Windows 10: right-click Start → **Windows PowerShell (Admin)**; or start PowerShell / Terminal and use **Run as administrator**).
2. **Paste for stable channel**

```powershell
irm "https://christitus.com/win" | iex
```

The WinUtil window should open when the script finishes loading.

## Import the saved software selection

This repository stores the install tick list as a JSON array of WinUtil package IDs:

`Software Stack/Configs/Basic Software Installs.json`

1. In WinUtil, open **Settings** using the **gear (cog) icon** in the top-right.
2. Choose **Import** and select that JSON file (full path if needed, e.g. the copy inside your clone of this repo).
3. The **Install** tab should reflect the imported selections. Go to **Install**, confirm the packages, then run the install action WinUtil provides for the selected apps (e.g. install / apply, per the current UI).

If import fails, update WinUtil (recent releases fixed several import/export issues; see the [winutil repo](https://github.com/ChrisTitusTech/winutil)). Avoid odd characters in the file path when troubleshooting.

## Tweaks: O&O ShutUp10++ and `ooshutup10.cfg`

WinUtil can **launch** [O&O ShutUp10++](https://www.oo-software.com/en/shutup10) from the **Tweaks** tab (documented under _Advanced Tweaks_ / one-click launch in the [Tweaks user guide](https://winutil.christitus.com/userguide/tweaks/)). It downloads and starts the portable `OOSU10.exe`; it does **not** automatically load this repo’s config—you apply that inside O&O.

1. Open the **Tweaks** tab in WinUtil.
2. Find the control that **runs / opens O&O ShutUp10++** (under the advanced / caution-related tweak area, per the current WinUtil build).
3. After O&O ShutUp10++ opens, **import** this file:

`Software Stack/Configs/ooshutup10.cfg`

Use O&O’s **File → Import** (or your build’s equivalent) and point it at `ooshutup10.cfg` in your clone of this repo.

4. **Review every option** in O&O (privacy and telemetry tweaks can affect updates, apps, and networking), then apply only what you intend. Reboot if the tool recommends it.

**Optional (outside WinUtil):** You can also start O&O ShutUp10++ with a config path as a command-line argument if you already have `OOSU10.exe`, then confirm in the UI before applying—see O&O’s documentation for the exact switches for your version.

## Safety and scope

- Run WinUtil and installers when you are ready for **system-wide** changes; have a **restore point** or backup if you rely on the machine for work.
- **Tweaks** and **O&O ShutUp10++** can disable telemetry, sync, or features you might still want—treat `ooshutup10.cfg` as a starting point, not a blind “apply all.”
