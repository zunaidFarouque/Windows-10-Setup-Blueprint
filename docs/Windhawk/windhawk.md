# Windhawk Setup

## Why Windhawk?

Windhawk replaces the need for messy, permanent registry hacks or obscure tweakers. It acts as a transparent, open-source marketplace that safely injects mods into Windows processes in real-time. If something breaks, simply disabling the mod safely reverts the system behavior immediately.

## 📤 How to Backup

Run `scripts/backup_windhawk.ps1` as Administrator.
Windhawk does not have a native export button. This script automatically pulls your installed mod files from `C:\ProgramData\Windhawk` and exports your customized mod configurations from the Windows Registry.

## 📥 How to Restore

1. Install the Windhawk application on the fresh Windows setup.
2. Run `scripts/restore_windhawk.ps1` as Administrator.
   This script stops the Windhawk background service, injects your backed-up registry settings and mod files, and restarts the service so your tweaks take effect immediately.
