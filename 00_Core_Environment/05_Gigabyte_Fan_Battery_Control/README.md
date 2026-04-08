# Gigabyte Fan Battery Control (GFBC) prereq guide

Download GFBC first (if you do not already have it): [Gigabyte Fan Battery Control (GitHub)](https://github.com/Ixmoon/Gigabyte-Fan-Battery-Center)

This guide is for my laptop: **Gigabyte Aorus 15 9MF**.

Use this only if you **do not install Gigabyte Control Center (GCC)**.  
I skip GCC because it is bloated and adds unnecessary background load.

## Why this is needed

GFBC needs `acpimof.dll` registered through the `WmiAcpi` service path.  
If GCC was never installed, this WMI provider is usually missing, so GFBC cannot control fan/battery features correctly.

## Source options

- Official source path: download GCC from Gigabyte support and extract it:  
  [Gigabyte Control Center download](https://www.gigabyte.com/Support/Utility?kw=GIGABYTE+Control+Center&p=1)
- Local trusted copy in this repo: [`acpimof.dll`](acpimof.dll)

## What the injection script does (no-code summary)

Script: [`Inject-WMI_put_me_in_extracted_GCC_installer.ps1`](Inject-WMI_put_me_in_extracted_GCC_installer.ps1)

1. Verifies it is running as Administrator.
2. Checks that `acpimof.dll` exists in the same folder as the script.
3. Copies `acpimof.dll` to `C:\Windows\SysWOW64`.
4. Creates/uses registry path `HKLM:\SYSTEM\CurrentControlSet\Services\WmiAcpi`.
5. Writes `MofImagePath` to point at `C:\Windows\SysWOW64\acpimof.dll`.
6. Prompts for reboot so Windows can load the WMI provider properly.

## Quick usage

1. Put the script in the extracted GCC folder (or use this repo folder where `acpimof.dll` is present).
2. Run the script as Administrator.
3. Reboot.
4. Then run GFBC.

