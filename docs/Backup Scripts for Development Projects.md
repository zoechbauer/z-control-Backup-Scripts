# Backup of Development Projects

This guide explains how to use the provided PowerShell and batch scripts to back up your development project folders and files. These scripts help you safeguard your work by copying all relevant files and folders, with flexible logging options.

## Purpose

The backup scripts are designed to:
- Recursively copy all content from a source directory to a backup destination.
- Exclude folders commonly not needed in backups, such as `.angular`, `node_modules`, `www`, and `dist`.
- Log processed items (folders and/or files) to a CSV file for audit and verification.

## Note on Project Types

**This script is targeted for Angular and IONIC projects.**  
For other project types, you may need to add additional folders to the excluded list to avoid backing up unnecessary files (such as build outputs, dependencies, or IDE folders).

To customize the excluded folders, edit the following part of the PowerShell script (`backup-dev.ps1`):

```powershell
# Excluded folder names
$excludeFolders = @(".angular", "node_modules", "www", "dist")
```

For example, to exclude `.next` and `.venv` for Next.js or Python projects:

```powershell
$excludeFolders = @(".angular", "node_modules", "www", "dist", ".next", ".venv")
```

## Script Overview

### Files

- **backup-dev.ps1**  
  PowerShell script that performs the backup and logging.  
  Allows you to specify whether to log only folders or both folders and files.

- **backup-dev-task.bat**  
  Batch file to run the PowerShell script.  
  Accepts a logging mode parameter (`FoldersOnly` or `FoldersAndFiles`).  
  Can be used interactively or scheduled as a Windows Task for automated backups.

- **logging-folders-and-files**  
  Contains sample log files (`BACKUP.csv`, `BACKUP.xlsx`) generated when using the `FoldersAndFiles` logging mode.

- **logging-folders-only**  
  Contains sample log files (`BACKUP.csv`, `BACKUP.xlsx`) generated when using the `FoldersOnly` logging mode.

## How to Use

1. Open a command prompt in the `backup-script` folder.
2. Run the batch file with the desired logging mode:
   ```
   backup-dev-task.bat FoldersAndFiles
   ```
   or
   ```
   backup-dev-task.bat FoldersOnly
   ```
   If no parameter is provided, it defaults to `FoldersAndFiles`.

3. The batch file will execute the PowerShell script with the specified logging mode.

4. To run the PowerShell script directly with custom parameters:
   ```
   powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\backup-dev.ps1" -source "C:\SOURCE-ACTIVE" -backupDest "C:\BACKUP\DEV-PROJECTS" -logFile "C:\BACKUP\DEV-PROJECTS\backup.csv" -LogMode FoldersAndFiles
   ```

## Scheduled Task

- You can use `backup-dev-task.bat` in a Windows Scheduled Task to automate backups.
- Set the task to run the batch file at your preferred schedule.
- Ensure the user account running the task has permission to access the source and backup directories.

## Notes

- The backup destination and log file paths can be customized in the PowerShell script or via parameters.
- Excluded folders (`.angular`, `node_modules`, `www`, `dist`) are not backed up by default.
- The log file records each processed item with timestamp, name, type, directory, and full path.
- Use the logging mode parameter to control whether only folders or both folders and files are logged.
- Sample log files are available in the `logging-folders-and-files` and `logging-folders-only` subfolders for reference.

---

_Last updated: December 5, 2025_