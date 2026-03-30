# Windows 10 Setup Blueprint

A comprehensive, organized repository of runbooks, settings, scripts, and software lists to rebuild a Windows 10 environment from scratch.

## What this repo is for

- Capture **exact tools and configs** you use across fresh installs.
- Provide **step‑by‑step runbooks** so you can go from bare Windows → fully tuned workstation without guesswork.
- Make everything **browsable from GitHub / GitHub Pages** via simple markdown links.

## Recommended setup order

1. **Core environment (baseline + updates)**
   - [Install software with WinUtil](00_Core_Environment/01%20Install%20software%20with%20WinUtil.md)
   - [Install software (UniGetUI + System)](00_Core_Environment/02%20Install%20software%20(UniGetUI%20+%20System).md)
   - [Windhawk tweaks](00_Core_Environment/11%20Windhawk/windhawk.md)
2. **UX and aesthetics**
   - [UX and Aesthetics software hub](01_UX_and_Aesthetics/Software.md) — typing/text workflow, desktop tools, social media apps, and more.
3. **Portable ecosystem**
   - [Portable ecosystem overview](02_Portable_Ecosystem/Portable_Ecosystem.md)
4. **Domain‑specific stacks (by folder)**
   - `11_GIS_and_Academic/`:
     - [Academic / research software](11_GIS_and_Academic/Academic/Academic%20software.md)
     - [GIS tools](11_GIS_and_Academic/GIS/GIS.md)
   - `12_Audio_and_VJ/`:
     - [Music production](12_Audio_and_VJ/Music/Music%20Production.md)
     - [Live performance](12_Audio_and_VJ/Music/Live%20Performance.md)
     - [VJ tools](12_Audio_and_VJ/VJ/VJ.md)
   - `13_Visuals_and_Design/`:
     - [Photography & image editing](13_Visuals_and_Design/Photography/Photography%20and%20Image%20Editing.md)
     - [Videography & editing](13_Visuals_and_Design/Videography/Videography%20and%20editing.md)
     - [Design tools](13_Visuals_and_Design/Designing/Designing.md)
     - [Architecture tools](13_Visuals_and_Design/Architecture/Architecture.md)
   - `14_Programming_and_Docker/`:
     - [Programming environment](14_Programming_and_Docker/Programming/Programming.md)
5. **Automation & macros**
   - [Macro collection](My-Macros/readme.md)
   - [Python macro scripts](My-Macros/Python%20scripts/readme.md)

## Repository map (high level)

- `00_Core_Environment/` – Baseline OS setup, WinUtil runbook, UniGetUI/system installs, and Windhawk configs.
- `01_UX_and_Aesthetics/` – UX tools, media listening, social apps, CopyQ, Foobar/Deskband, and other desktop enhancements.
- `02_Portable_Ecosystem/` – Portable apps and workflows that can move between machines.
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
