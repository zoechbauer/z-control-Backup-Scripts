# Backup Scripts for Non-Versioned Development Projects

This folder contains scripts for backing up development projects and files that are not managed by version control systems (such as GitHub). These scripts help you safeguard important work, configuration files, and project assets before deleting, migrating, or archiving projects.

## Purpose

- Back up non-versioned projects, temporary work, and example code.
- Exclude large or unnecessary folders to keep backups lean.
- Use distinct source and backup destinations, separate from the main backup scripts.

## Files

- **backup-dev-div-task.bat**  
  Batch file to run the PowerShell backup script for non-versioned projects.  
  Accepts parameters for logging mode and can be used interactively or scheduled.

- **backup-dev-div.ps1**  
  PowerShell script to recursively back up all content from a specified source to a backup destination.  
  Supports logging options for folders only or both folders and files.

- **README.md**  
  This documentation file.

## Differences from Main Backup Script

These scripts use different source and backup destinations and have distinct names compared to the main backup script.  
- The script names (`backup-dev-div.ps1`, `backup-dev-div-task.bat`) are unique to avoid confusion with the main backup process.
- The default source and backup paths are set specifically for non-versioned or temporary projects.
- You can customize excluded folders and logging options independently from the main backup script.

## Usage

1. Open a command prompt in this folder.
2. Run the batch file with the desired logging mode:
   ```
   backup-dev-div-task.bat FoldersAndFiles
   ```
   or
   ```
   backup-dev-div-task.bat FoldersOnly
   ```
   If no parameter is provided, it defaults to `FoldersAndFiles`.

3. The batch file will execute the PowerShell script with the specified logging mode.

4. To run the PowerShell script directly with custom parameters:
   ```
   "C:\Program Files\PowerShell\7\pwsh.exe" -NoProfile -ExecutionPolicy Bypass -File ".\backup-dev-div.ps1" -source "C:\SOURCE-ACTIVE" -backupDest "C:\BACKUP\NON_COMMITTED" -logFile "C:\BACKUP\NON_COMMITTED\backup.csv" -LogMode FoldersAndFiles
   ```

## Scheduled Task

- You can use the batch file in a Windows Scheduled Task to automate backups.
- Set the task to run the batch file at your preferred schedule.
- Ensure the user account running the task has permission to access the source and backup directories.

## Notes

- The backup destination and log file paths can be customized in the PowerShell script or via parameters.
- Excluded folders (such as dependencies and build outputs) can be adjusted in the script.
- The log file records each processed item with timestamp, name, type, directory, and full path.
- Use the logging mode parameter to control whether only folders or both folders and files are logged.

---

_Last updated: December 12, 2025_

