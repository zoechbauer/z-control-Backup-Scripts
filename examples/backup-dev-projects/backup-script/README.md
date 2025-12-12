# Backup Script Folder

This folder contains scripts and documentation for backing up development project folders and files, with flexible logging options.

## Files

- **backup-dev.ps1**  
  PowerShell script to recursively back up all content from a source directory to a backup destination, excluding folders such as `.angular`, `node_modules`, `www`, and `dist`.  
  The script logs processed items (folders and/or files) to a CSV file, with options to log only folders or both folders and files.

- **backup-dev-task.bat**  
  Batch file to run the PowerShell backup script.  
  Accepts a logging mode parameter (`FoldersOnly` or `FoldersAndFiles`).  
  Can be used interactively or scheduled as a Windows Task for automated backups.

## Directory Structure

This folder contains the subfolders:

- **logging-folders-and-files**  
  Contains `BACKUP.csv` and `BACKUP.xlsx` which show the log output when the parameter `FoldersAndFiles` is used.

- **logging-folders-only**  
  Contains `BACKUP.csv` and `BACKUP.xlsx` which show the log output when the parameter `FoldersOnly` is used.

- **backup-non-committed-dev-projects**  
  Contains scripts for backing up non-committed development projects. These scripts use different source and backup destinations and have distinct names compared to the main backup script.

## Usage

1. Open a command prompt in this folder.
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
   "C:\Program Files\PowerShell\7\pwsh.exe" -NoProfile -ExecutionPolicy Bypass -File ".\backup-dev.ps1" -source "C:\SOURCE-ACTIVE" -backupDest "C:\BACKUP\DEV-PROJECTS" -logFile "C:\BACKUP\DEV-PROJECTS\backup.csv" -LogMode FoldersAndFiles
   ```

## Scheduled Task

- You can use `backup-dev-task.bat` in a Windows Scheduled Task to automate backups.
- Set the task to run the batch file at your preferred schedule.
- Ensure the user account running the task has permission to access the source and backup directories.

## Notes

- The backup destination and log file paths can be customized in the PowerShell script or via parameters.
- Excluded folders (`.angular`, `node_modules`, `www`, `dist`) are not backed up.
- The log file records each processed item with timestamp, name, type, directory, and full path.
- Use the logging mode parameter to control whether only folders or both folders and files are logged.