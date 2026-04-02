## Quick Start

- [`___Copy_Shortcuts_to_StartMenu.ps1`](___Copy_Shortcuts_to_StartMenu.ps1): Copies shortcuts from its current folder to a dedicated Start Menu folder (`My Shortcuts`) so portable apps appear like normally installed apps. It also clears Explorer's icon cache and restarts Explorer to refresh shortcut icons.
  Place this script in `D:\_installed\_Shortcuts`. After creating shortcuts, run it to publish them to the Start Menu.
- [`Portable_Apps_with_Scoop_UniGetUI.ubundle`](Portable_Apps_with_Scoop_UniGetUI.ubundle): UniGetUI export bundle for this portable setup. Use it as a restore/import snapshot for the Scoop and Winget app set managed by the `scoop_UGU` workflow.
