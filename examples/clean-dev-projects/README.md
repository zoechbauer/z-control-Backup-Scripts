# Clean Dev Projects Scripts

This folder contains scripts and documentation for cleaning up development project folders. These tools help you reclaim disk space and keep your dev environments tidy by removing large or unnecessary folders (such as `node_modules`, `www`, `dist`, and `.angular`) from project directories. The structure and usage are similar to the backup script folder, making it easy to automate or run interactively.

---

## Contents

- **cleanup-dev.ps1**  
  PowerShell script that recursively deletes folders named `.angular`, `node_modules`, `www`, or `dist` at any depth within the specified source directory.  
  - Logs each deleted folder (and optionally, all files within) to a CSV file.
  - Supports two logging modes: `FoldersOnly` and `FoldersAndFiles`.
  - The log file path can be specified as a parameter; by default, it writes to `CLEANUP.csv` in the script directory.

- **cleanup-dev-task.bat**  
  Batch file to launch the PowerShell cleanup script with the desired parameters.  
  - Accepts a source path, logging mode, and optional log file path as arguments.
  - Uses the script’s directory for the default log file location.
  - Can be run manually or scheduled as a Windows Task for automated cleanups.

---

## Usage

### Run via Batch File

1. Open a command prompt in this folder.
2. Run the batch file with your desired options:
   ```
   cleanup-dev-task.bat [SourcePath] [FoldersOnly|FoldersAndFiles] [LogFilePath]
   ```
   - If no parameters are provided, it defaults to cleaning `C:\SOURCE-ACTIVE-DIV`, logging both folders and files, and writing the log to `CLEANUP.csv` in the script directory.
   - Examples:
     ```
     cleanup-dev-task.bat D:\Projects FoldersOnly
     cleanup-dev-task.bat "C:\My Projects" FoldersAndFiles "C:\Logs\cleanup-log.csv"
     ```
   - **Tip:** If your paths contain spaces, enclose them in quotes.

### Run PowerShell Script Directly

You can run the PowerShell script directly for more control:
```
"C:\Program Files\PowerShell\7\pwsh.exe" -NoProfile -ExecutionPolicy Bypass -File ".\cleanup-dev.ps1" -source "C:\SOURCE-ACTIVE-DIV" -logFile "C:\SOURCE-ACTIVE-DIV\cleanup.csv" -LogMode FoldersAndFiles
```
- `-source` specifies the root directory to clean.
- `-logFile` sets the output CSV log file path.
- `-LogMode` can be `FoldersOnly` or `FoldersAndFiles`.

---

## Scheduled Task

- You can automate cleanups by scheduling `cleanup-dev-task.bat` with Windows Task Scheduler.
- Set the task to run at your preferred interval (e.g., weekly or monthly).
- Ensure the user account running the task has permission to access and modify the target directories.

---

## Notes

- The script only deletes folders with exact names: `.angular`, `node_modules`, `www`, or `dist` (case-insensitive).
- The log file records each deleted folder and, if enabled, all files within, with columns: timestamp, name, type, directory, deleted, and full path.
- The log file is overwritten on each run.
- Use `FoldersOnly` to log only deleted folders, or `FoldersAndFiles` to log both folders and files.
- You can customize the source path and log file location via parameters or by editing the batch/script defaults.
- The default log file is `CLEANUP.csv` in the same directory as the batch script.

---

## Example Log Entry

```
Timestamp;Name;Type;Directory;Deleted;Full Path
2025-12-14 15:27:01;node_modules;Folder;C:\Projects\MyApp;true;C:\Projects\MyApp\node_modules
2025-12-14 15:27:02;index.js;File;C:\Projects\MyApp\node_modules\lib;true;C:\Projects\MyApp\node_modules\lib\index.js
```

---

For more details or advanced usage, see the inline documentation in each script.

_Last updated: December 15, 2025_