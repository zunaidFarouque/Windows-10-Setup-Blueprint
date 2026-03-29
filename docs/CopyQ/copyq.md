# CopyQ Setup

## Why CopyQ?

After testing numerous clipboard managers, CopyQ stands out as the definitive choice. It goes beyond simple history tracking—its true power lies in its versatility, deep customizability, and advanced scriptability. Plus, being an open-source, cross-platform tool means this exact workflow translates perfectly if you ever need to work outside of the Windows ecosystem.

## 📤 How to Backup Settings & Commands

To keep everything version-controlled in this repository, you need to extract your configurations from your current working setup.

### 1. Exporting Custom Commands

1. Open the CopyQ main window.
2. Press `F6` to open the **Command/Global Shortcut dialog**.
3. Select all your custom commands.
4. Click on **Save Selected** (or export).
5. Save the generated `.ini` file into this repository (e.g., create a folder called `config-files` and save it as `copyq_commands.ini`).

### 2. Backing up Application Settings

CopyQ stores its core configurations, tweaks, and UI layout in your AppData folder.

1. Press `Win + R`, type `%APPDATA%\copyq`, and hit Enter.
2. Copy the `copyq.ini` file.
3. Paste this file into your repository's `config-files` folder.

_(Optional: If you want to back up your actual pinned clipboard history tabs, copy the folder/files ending in `.dat` in the same directory. However, for a fresh install, usually just the settings and commands are needed)._

## 📥 How to Restore on a Fresh Install

When setting up a new Windows machine, follow these steps to instantly restore your workflow:

1. **Install CopyQ** (via Winget or manual download).
2. **Restore Settings:**

- Ensure CopyQ is completely closed (right-click the tray icon and select 'Exit').
- Press `Win + R`, type `%APPDATA%\copyq`, and hit Enter.
- Drop your backed-up `copyq.ini` file into this folder, replacing the default one.

3. **Restore Commands:**

- Open CopyQ.
- Press `F6` to open the Command dialog.
- Click **Load Commands** and select your `copyq_commands.ini` file from this repo.
- Click **Apply** and **OK**.

## Setting Up WinMerge for Instant Diff Between the Last 2 Clipboard Items

To instantly compare your last two clipboard entries using WinMerge and CopyQ:

1. **Install WinMerge**  
   It’s recommended to install [WinMerge](https://winmerge.org/) using PortableApps.com for portability.
   configure according to the guide here: [DIFF: Compare and merge](<../../Software Stack/my UX/Typing.md#diff-compare-and-merge>)

2. **Open CopyQ Commands Window**
   - Launch CopyQ.
   - Press `F6` to open the **Command / Global Shortcut** dialog.

3. **Locate the Diff Command**
   - Find and select the `Diff Latest Items` command.

4. **Configure the WinMerge Path**
   - Look for a command line similar to:

```
execute('winmergeu', '/e', '/x', '/u', '/fl', '/dl', 'item1', '/dr', 'item2', name1, name2)
```

- If you installed WinMerge in a custom location, replace `'winmergeu'` with the full path to the `winmergeu.exe` executable. For example:

```
execute('C:/PortableApps/WinMerge/WinMergePortable.exe', '/e', '/x', '/u', '/fl', '/dl', 'item1', '/dr', 'item2', name1, name2)
```

- Save your changes.

Now, when you trigger the command, CopyQ will open your two most recent clipboard entries side by side in WinMerge for easy comparison.
