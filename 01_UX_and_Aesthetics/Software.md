# UX and Aesthetics software hub

This is the single source for UX/aesthetics software lists.

> `scoop_UGU` means install using UniGetUI with the `scoop` package manager.
>
> Additional software can be found in specialized software tables, for example [13_Visuals_and_Design/Designing/Designing.md](../13_Visuals_and_Design/Designing/Designing.md).

Related guides:

- [Portable ecosystem quick start](10_Portable_Ecosystem/Portable_Ecosystem.md)
- [CopyQ setup (my commands and WinMerge integration)](11_CopyQ/copyq.md)
- [foobar2000 setup with Deskband Controls](12_Foobar_&_Deskband_Controls/1._foobar2000_Setup.md)
- [FB Messenger setup (Custom Shortcut)](13_FB_Messenger/fb_messenger.md)

## Typing and text workflow


| Software                        | Install Method                                | What it does / Why I need it                |
| ------------------------------- | --------------------------------------------- | ------------------------------------------- |
| [CopyQ](../docs/CopyQ/copyq.md) | UniGetUI                                      | Clipboard manager with persistent history.  |
| **WhisperTyping**               | [Manual](https://whispertyping.com/download/) | Voice typing with a generous free tier.     |
| **Typeless**                    | UniGetUI                                      | Auto-format and cleanup for dictated text.  |
| aText                           | scoop_UGU                                     | Text expansion with rich text and scripting |


For CopyQ, you have to specify the WinMerge.exe location in the direct diff command.

WinMerge settings I use:

- Compare > General: moved block detection on, align similar lines on, diff algorithm `minimal`, indent heuristic on.
- Editor > Compare/Merge: copy granularity `Char`, view line differences on, line difference coloring character-level.

## Remote control


| Software     | Install Method | What it does / Why I need it        |
| ------------ | -------------- | ----------------------------------- |
| **Stardesk** | UniGetUI       | Current best remote desktop choice. |


## Listening and Managing Music


| Software                                                        | Install Method                                          | What it does / Why I need it                                     |
| --------------------------------------------------------------- | ------------------------------------------------------- | ---------------------------------------------------------------- |
| [foobar2000](Foobar_&_Deskband_Controls/1._foobar2000_Setup.md) | Manual (D)                                              | Play local downloaded songs.                                     |
| **Harmony Music**                                               | [Manual (D)](https://github.com/anandnet/Harmony-Music) | Play and Download songs.                                         |
| **Muffon**                                                      | [scoop_UGU](https://muffon.netlify.app/)                | Discover new music.                                              |
| **OnTheSpot**                                                   | scoop_UGU                                               | Grab and organize music downloads from supported services.       |
| **MusicBrainz Picard**                                          | scoop_UGU                                               | Tagger and organizer for music files using MusicBrainz database. |


## Gaming input tools


| Software    | Install Method                    | What it does / Why I need it                     |
| ----------- | --------------------------------- | ------------------------------------------------ |
| **X360CE**  | [Manual](https://www.x360ce.com/) | Controller emulation for older/non-native games. |
| **HidHide** | UniGetUI                          | Hide physical controllers to avoid double input. |


## General UX and desktop tools


| Software                            | Install Method                                     | What it does / Why I need it                               |
| ----------------------------------- | -------------------------------------------------- | ---------------------------------------------------------- |
| **PowerToys**                       | UniGetUI                                           | Power-user utilities.                                      |
| **EverythingCmdPal**                | UniGetUI                                           | Search/launcher workflow.                                  |
| **Internet Download Manager (IDM)** | [Manual](https://www.internetdownloadmanager.com/) | Download accelerator with browser integration and queuing. |
| [Rainmeter](../docs/Rainmeter/)     | UniGetUI (D)                                       | Desktop widgets; setup details are in the repo guide.      |
| **Nearby share / Quick share**      | UniGetUI                                           | Fast local device file transfer.                           |
| **Kando**                           | scoop_UGU                                          | Radial launcher menu.                                      |
| **Microsoft To Do**                 | UniGetUI                                           | Quick task capture and sync.                               |


## Social media


| Software                                        | Install Method | What it does / Why I need it                                                         |
| ----------------------------------------------- | -------------- | ------------------------------------------------------------------------------------ |
| [FB Messenger](13_FB_Messenger/fb_messenger.md) | Manual (D)     | Messenger app: opens messenger.com as a standalone window. See repo guide for setup. |
| **Telegram**                                    | scoop_UGU (D)  | Secure messaging with multi-device sync and channels.                                |


## System and diagnostics


| Software                            | Install Method                                                                       | What it does / Why I need it                                          |
| ----------------------------------- | ------------------------------------------------------------------------------------ | --------------------------------------------------------------------- |
| **Autoruns**                        | scoop_UGU                                                                            | Inspect and control startup entries and autoruns.                     |
| **BleachBit**                       | scoop_UGU                                                                            | Clean temporary files and reclaim storage space.                      |
| **ContextMenuManager**              | scoop_UGU                                                                            | Clean and speed up right-click menu configuration.                    |
| **CPU-Z**                           | scoop_UGU                                                                            | Check CPU, memory, and motherboard hardware details.                  |
| **CrystalDiskInfo**                 | scoop_UGU                                                                            | Monitor disk SMART health and temperatures.                           |
| **Custom Resolution Utility (CRU)** | [scoop_UGU](https://customresolutionutility.net/#download-custom-resolution-utility) | Fix or override display modes when EDID data is wrong.                |
| **Detect It Easy (DIE)**            | scoop_UGU                                                                            | Identify packers, compilers, and executable signatures.               |
| **Easy Context Menu**               | scoop_UGU                                                                            | Toggle shell-menu entries and desktop integrations quickly.           |
| **Firewall App Blocker**            | scoop_UGU                                                                            | Quickly block apps through Windows Firewall rules.                    |
| **MSI Afterburner**                 | scoop_UGU                                                                            | FPS and hardware OSD monitoring while gaming and benchmarking.        |
| **PatchCleaner**                    | scoop_UGU                                                                            | Find and clean orphaned Windows Installer patch files.                |
| **Process Explorer**                | scoop_UGU                                                                            | Deep process and handle inspection beyond Task Manager.               |
| **Process Hacker**                  | scoop_UGU                                                                            | Advanced process and service monitoring and control.                  |
| **Process Monitor**                 | scoop_UGU                                                                            | Trace file, registry, and process activity in real time.              |
| **Registry Finder**                 | scoop_UGU                                                                            | Faster registry search and editing workflow than RegEdit.             |
| **VCRedist 2022**                   | scoop_UGU                                                                            | Install Microsoft Visual C++ runtime dependencies for many apps.      |
| **Ventoy**                          | scoop_UGU                                                                            | Maintain a multiboot USB drive without reformatting each new ISO.     |
| **Wise Auto Shutdown**              | UniGetUI                                                                             | Scheduled shutdown and restart utility for maintenance tasks.         |
| **Wise Program Uninstaller**        | UniGetUI                                                                             | Clean uninstall when apps leave junk behind.                          |
| **Windows Update Blocker**          | scoop_UGU                                                                            | Toggle Windows Update services when tighter update control is needed. |
| **WizTree**                         | scoop_UGU                                                                            | Rapid disk usage analysis to find large folders and files.            |

For MSI Afterburner, keep `Enable hardware control and monitoring` unchecked in `Settings > General` (as shown in your screenshot).


## Productivity and file utilities


| Software           | Install Method                                      | What it does / Why I need it                                        |
| ------------------ | --------------------------------------------------- | ------------------------------------------------------------------- |
| **7-Zip**          | scoop_UGU                                           | Archive extraction and compression utility.                         |
| **XYPlorer**       | [Manual (D)](https://www.xyplorer.com/download.php) | Advanced dual-pane file manager and Explorer replacement.           |
| **CCleaner**       | scoop_UGU                                           | Extra system cleanup and maintenance toolkit.                       |
| **Espanso**        | scoop_UGU                                           | System-wide text expansion for repeated snippets.                   |
| **File Converter** | scoop_UGU                                           | Context-menu file conversion for everyday formats.                  |
| **Krokiet**        | scoop_UGU                                           | Data cleaner and deduper for large storage cleanup.                 |
| **qBittorrent**    | scoop_UGU                                           | Torrent client for controlled peer-to-peer downloads.               |
| **ReNamer**        | scoop_UGU                                           | Rule-based bulk renaming for files and folders.                     |
| **Rufus**          | scoop_UGU                                           | Create bootable USB drives from ISO images.                         |
| **ShareX**         | scoop_UGU                                           | Screenshot, capture, and share automation toolkit.                  |
| **SpeedCrunch**    | scoop_UGU                                           | Desktop calculator with expression history and fast keyboard input. |


## Privacy, communication, and access


| Software        | Install Method | What it does / Why I need it                   |
| --------------- | -------------- | ---------------------------------------------- |
| **Tor Browser** | scoop_UGU      | Privacy-focused browsing over the Tor network. |
| **Zoom**        | scoop_UGU      | Video meetings, screen sharing, and calls.     |


