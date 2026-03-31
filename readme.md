# Windows 10 Setup Blueprint

A comprehensive, organized repository of runbooks, settings, scripts, and software lists to rebuild a Windows 10 environment from scratch.

## What this repo is for

- Capture **exact tools and configs** you use across fresh installs.
- Provide **step‑by‑step runbooks** so you can go from bare Windows → fully tuned workstation without guesswork.
- Make everything **browsable from GitHub / GitHub Pages** via simple markdown links.

## Recommended setup order

1. **Core environment (baseline + updates)**
   1. [Install software with WinUtil](00_Core_Environment/01_Install_software_with_WinUtil.md)
   2. [Install software (UniGetUI)](00_Core_Environment/02_Install_software_with_UniGetUI.md)
   3. [Optimizations & tweaks](00_Core_Environment/03_optimizations_and_tweaks.md)

   Extra detailed doc:
   - [Windhawk tweaks](00_Core_Environment/11_Windhawk/windhawk.md)

2. **UX and aesthetics**
   - [UX and Aesthetics software hub](01_UX_and_Aesthetics/Software.md) — unified hub for UX-facing tools and links to specialized setup guides.

   Extra detailed docs:
   - [Portable ecosystem quick start](01_UX_and_Aesthetics/10_Portable_Ecosystem/Portable_Ecosystem.md)
   - [CopyQ setup](01_UX_and_Aesthetics/11_CopyQ/copyq.md)
   - [foobar2000 setup](01_UX_and_Aesthetics/12_Foobar_&_Deskband_Controls/1._foobar2000_Setup.md)
   - [FB Messenger setup](01_UX_and_Aesthetics/13_FB_Messenger/fb_messenger.md)

3. **Domain‑specific stacks (by folder)**
   - `11_GIS_and_Academic/`:
     - [Academic / research software](11_GIS_and_Academic/Academic/Academic_software.md)
     - [GIS tools](11_GIS_and_Academic/GIS/GIS.md)
   - `12_Audio_and_VJ/`:
     - [Music production](12_Audio_and_VJ/Music/Music_Production.md)
     - [Live performance](12_Audio_and_VJ/Music/Live_Performance.md)
     - [VJ tools](12_Audio_and_VJ/VJ/VJ.md)
   - `13_Visuals_and_Design/`:
     - [Photography & image editing](13_Visuals_and_Design/Photography/Photography_and_Image_Editing.md)
     - [Videography & editing](13_Visuals_and_Design/Videography/Videography_and_editing.md)
     - [Design tools](13_Visuals_and_Design/Designing/Designing.md)
     - [Architecture tools](13_Visuals_and_Design/Architecture/Architecture.md)
   - `14_Programming_and_Docker/`:
     - [Programming environment](14_Programming_and_Docker/Programming/Programming.md)
4. **Automation & macros**
   - [Macro collection](My-Macros/readme.md)
   - [Python macro scripts](My-Macros/Python_scripts/readme.md)

## Repository map (high level)

- `00_Core_Environment/` – Baseline OS setup, WinUtil runbook, UniGetUI/system installs, and Windhawk configs.
- `01_UX_and_Aesthetics/` – UX hub, portable ecosystem quick start, CopyQ, Foobar/Deskband, Messenger, and other desktop enhancements.
- `11_GIS_and_Academic/` – GIS, mapping, and academic/research software stacks.
- `12_Audio_and_VJ/` – Music production, live performance, and VJ/VFX tools.
- `13_Visuals_and_Design/` – Photography, videography, design, and architecture workflows.
- `14_Programming_and_Docker/` – Programming environment, language runtimes, and Docker‑related notes.
- `My-Macros/` – Macro libraries and helper scripts.
- `TODO.md` – Scratchpad for ideas, pending tools, and future sections.

## Browsing on GitHub / GitHub Pages

All links above are **relative paths inside this repo**, so they work both on:

- The main GitHub repository page.
- The GitHub Pages project site (project README renders as the landing page, and links drill into the same markdown files).

Use this `readme.md` as the starting index and follow links into each numbered folder for detailed setup instructions.
