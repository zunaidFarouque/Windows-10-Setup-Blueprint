# Software Stack

## The Automated Installer

Instead of manually downloading `.exe` files, this repository uses a Winget PowerShell script to bulk-install the core software stack.

## 📦 How to Install Everything

1. Open PowerShell as Administrator.
2. Run the `scripts/install_software.ps1` script.
3. Wait for the process to complete. Winget will automatically download, verify, and silently install every application in the list.

## 🔍 How to Add New Software

To add a new application to the automated installer, you need its exact Winget ID.

1. Open PowerShell.
2. Type `winget search "App Name"` (e.g., `winget search "Google Chrome"`).
3. Find the exact string under the **Id** column.
4. Add that ID to the `$softwareList` array in the `install_software.ps1` script.
