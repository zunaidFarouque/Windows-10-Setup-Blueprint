# Live Performance Quick Runbook

Use this as a fast pre-show checklist.

## LatencyMon baseline check (start here)

- Run a `60-second` LatencyMon test first.
- Open the `Drivers` tab.
- Check each entry for DPC latency occurrence values.
- If any entry goes above `1 ms`, treat it as a problem.
- Ideal target: everything stays below `1 ms`.
- Fewer rows showing DPC latency is better.

### Usual culprits and what they mean

- `nvlddmkm.sys`: NVIDIA display driver latency (GPU driver stack behavior under load).
- `ACPI.sys`: power/firmware management latency (BIOS or platform power-state transitions).
- `msmpeng.exe`: Microsoft Defender background scanning overhead.
- `ndis.sys` (Wi-Fi): network driver stack activity, often from wireless adapters.

## General guide

## Step 1 (one-time work)

- Neutralize `nvlddmkm.sys` as much as possible with NVcleanstall:
  1. Do a clean install using NVcleanstall.
  2. Install only the Graphics Driver (skip all extra NVIDIA components).
  3. In the Tweaks page, enable:
     - `Disable Installer Telemetry & Advertising`
     - `Perform a Clean Installation`
- After install, open NVIDIA Control Panel and lock power for your real-time apps:
  - `3D Settings` -> `Program Settings` -> add your real-time performance software -> `Power management mode` = `Prefer maximum performance`.
- Add your performance folders to Windows Defender exclusions.

## Step 2 (every time work)

- Switch GPU MUX to dGPU in BIOS:
  - `Peripherals` -> `Switchable Graphics Devices` -> `PEG mode`.
  - `PEG mode` = discrete GPU path; `SG mode` = Optimus/switchable graphics path.
  - Use `PEG mode` so rendering stays on the GPU path and avoids extra handoff latency from GPU -> CPU/iGPU -> monitor.
- Set Windows power plan to maximum/high performance (I use a shortcut workflow too: [my shortcut system](my%20shortcut%20system.md)).
  - Ultimate power-plan baseline (recommended):
    1. Turn off hard disk after: `0 minutes` (`Never`)
    2. PCI Express -> Link State Power Management: `Off`
    3. Processor power management:
       - Minimum processor state: `100%`
       - Maximum processor state: `100%`
- For this laptop, use [Gigabyte Fan Battery Control (GFBC)](https://github.com/Ixmoon/Gigabyte-Fan-Battery-Center) instead of Gigabyte Control Center (GCC).
  - GCC is heavier and can increase background power usage.
  - To avoid battery polling that can trigger DPC latency, use Custom fan speed (`80%` or `100%`, based on load).
  - Keep GFBC minimized to tray; if it is closed/not active, fan control can hand back to BIOS, and BIOS-side behavior is less stable for low-latency work.
- Disable unnecessary devices (network, Bluetooth, biometrics, etc.) using my script that automates selected Device Manager device toggles.
- Disable Windows Update (Windows Update Blocker, installed via Scoop as a portable app).
- Stop CopyQ and other non-essential background utilities using automation scripts (`WorkspaceManager` profiles).
- Set all monitors to `60 Hz` (I use a shortcut for this in MultiMonitorTool).
  - For live work, keep both monitors on the same refresh rate and use the panel's originally supported refresh mode.
- Optional: set `Advanced system settings` -> `Performance settings` to `Best performance`, then re-enable `Smooth edges of screen fonts` (also automated in script/profile).
