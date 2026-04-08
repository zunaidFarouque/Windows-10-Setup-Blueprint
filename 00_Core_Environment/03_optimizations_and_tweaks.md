## Winscript (system tweaks and setup script)

Run [winscript](https://github.com/flick9000/winscript) (**admin required**):

```powershell
irm "https://winscript.cc/irm" | iex
```

- This runs the winscript one-liner. It loads a system optimization and setup interface with various tweaks, updates, and optional installs. Review the options and apply what you need.

## Optimizers & hardening

(If not available in Portable apps folder) Download `Optimizer` manually: [https://github.com/hellzerg/optimizer/releases/download/16.7/Optimizer-16.7.exe](https://github.com/hellzerg/optimizer/releases/download/16.7/Optimizer-16.7.exe)
It provides quick privacy settings, debloating, and system performance tweaks.

## Disable GameDVR and Game Bar hooks

### Why use this tweak

- Reduces background capture hooks from Xbox Game Bar/GameDVR.
- Can lower background overhead during live audio, gaming, and recording workflows.
- Helps avoid accidental capture overlays and hotkey triggers.

### Why you might not use this tweak

- You lose built-in Xbox Game Bar capture/recording features.
- Some users rely on the overlay for quick screenshots, clips, or social features.
- Future Windows updates may reset parts of these values, requiring re-apply.

### Apply (PowerShell script)

- Script: [`04_Optimization_Scripts/Disable-GameDVR-GameBar.ps1`](04_Optimization_Scripts/Disable-GameDVR-GameBar.ps1)
