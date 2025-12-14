# Examples Overview

This folder contains scripts and tools from my repositories to help back up non-committed files and folders from development projects, clean up unused or bulky dev project folders, and log disk space usage. These scripts are especially useful before deleting or migrating projects to ensure important configuration and environment files are not lost, and to monitor or reclaim disk usage across your projects.

---

## 📁 Folder: `backup-non-committed-project-files`

Scripts and instructions for backing up files and folders that are typically not committed to version control, such as:

- `.github`
- `.vscode`
- `.env.local`
- `src/index_DEBUG_FIREBASE-config.html`

### Example Projects

- Calculator project
- z-control landing-page project

Each project includes a `tools` folder with:
- PowerShell backup script
- Usage instructions
- Example log files

See the detailed guides in the [docs](../docs) folder for more information.

---

## 📁 Folder: `clean-dev-projects`

Scripts for cleaning up development project folders by removing large or unnecessary directories (like `node_modules`, `www`, `dist`, and `.angular`).  
Useful for reclaiming disk space in seldom-used or archived projects.

- **cleanup-dev.ps1**: PowerShell script to recursively delete specified folders and log deletions (folders and/or files) to a CSV file.
- **cleanup-dev-task.bat**: Batch file to run the PowerShell script with your chosen options. Can be run interactively or scheduled.

### Usage

- Run the batch file with:
  ```
  cleanup-dev-task.bat [SourcePath] [FoldersOnly|FoldersAndFiles]
  ```
  - Defaults to `C:\SOURCE-ACTIVE-DIV` and `FoldersAndFiles` if not specified.
- See the [Clean Dev Projects Scripts documentation](../docs/Cleanup%20Development%20Projects%20Scripts.md) for full details.

---

## 📁 Folder: `log-disk-space`

Contains scripts to log the sizes of disk drives or folders within a specified directory. Useful for monitoring disk usage, auditing project storage, and identifying large folders.

- **log-folder-sizes.bat**: Batch file to launch the PowerShell script. Supports specifying the root path, whether to include subfolders, and the search depth (including unlimited depth).
- **log-folder-sizes.ps1**: PowerShell script that scans the specified directory or disk drive and logs the size of each folder (and optionally subfolders) to both a CSV and a TXT file. Handles access errors gracefully and supports both PowerShell 5 and 7.

### Example Folders

This folder also contains 2 example folders.  
Each example folder includes:
- `terminal-log.txt`: Shows the used parameters for the script run.
- `FolderSizesLog.txt` and `FolderSizesLog.csv`: The resulting logs in TXT and CSV format.
- An Excel file: Contains the imported CSV data, sorted descending by size.

See [log-disk-space/README.md](log-disk-space/README.md) for full usage and details.

---

## 📁 Folder: `docs`

Contains documentation for all backup, cleanup, and logging scripts:

- **Backup Scripts for Development Projects.md**:  
  Guide for backing up entire development projects, with details on excluding unnecessary folders and automating backups.

- **Backup Scripts for non committed files.md**:  
  Guide for backing up only non-committed files and folders, with usage instructions and customization tips.

- **Cleanup Development Projects Scripts.md**:  
  Guide for cleaning up dev project folders by deleting bulky or unnecessary directories and logging the results.

- **Upgrade PowerShell 5 to 7.md**:  
  Step-by-step instructions for upgrading from Windows PowerShell 5.1 to PowerShell 7, including integration with VS Code and scheduled tasks.

---

## 📄 File examples

```
- src/index_DEBUG_FIREBASE-config.html
```

---

_Last updated: December 14, 2025_