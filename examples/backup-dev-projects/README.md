# Backup Script for Development Projects

This folder contains robust, flexible scripts for backing up development project folders, including both versioned and non-versioned files. The scripts are designed for easy automation and support a variety of parameter combinations.

---

## Folder Structure

```
backup-dev-projects/
├── README.md
├── scripts/
│   ├── backup-dev.ps1
│   ├── backup-dev-task.bat
├── logging-examples/
│   ├── logging-folders-and-files/
│   │   ├── BACKUP.csv
│   │   └── BACKUP.xlsx
│   └── logging-folders-only/
│       ├── BACKUP.csv
│       └── BACKUP.xlsx
└── parameter-examples/
    └── terminal-log.txt
```

---

## Scripts

- **backup-dev.ps1**: Main PowerShell script for backing up project folders.
- **backup-dev-task.bat**: Batch file entry point for launching the PowerShell script with parameters.

---

## Parameters

| Parameter     | Description                                                              | Default Value      | Notes                                |
|---------------|--------------------------------------------------------------------------|--------------------|--------------------------------------|
| `-Source`     | Path to the source folder to back up.                                    | Current directory  | Can be relative or absolute.         |
| `-BackupDest` | Path to the backup destination folder.                                   | `.\BACKUP`         | Can be relative or absolute.         |
| `-LogMode`    | Logging mode: `FoldersOnly` or `FoldersAndFiles`.                        | `FoldersOnly`      | Uses ValidateSet for safety.         |
| `-LogFile`    | Path to the log file (CSV) to write backup results.                      | `.\BACKUP.csv`     | Will be created/overwritten.         |

---

## Usage

### From Batch File

Run the batch file to launch the PowerShell script with default or custom parameters:

```bat
backup-dev-task.bat
```

Or with custom parameters:

```bat
backup-dev-task.bat "C:\MyProject" "D:\Backups\MyProject" "FoldersAndFiles" "D:\Backups\MyProject\backup.csv"
```

### Directly in PowerShell

```powershell
.\backup-dev.ps1 -Source "C:\MyProject" -BackupDest "D:\Backups\MyProject" -LogMode FoldersAndFiles -LogFile "D:\Backups\MyProject\backup.csv"
```

---

## Real Usage Examples

See [parameter-examples/terminal-log.txt](parameter-examples/terminal-log.txt) for real-world script runs and outputs.

**Summary of scenarios:**
- Running with all default parameters.
- Specifying only the source directory.
- Specifying all parameters, including custom log mode and log file.
- Handling of invalid `LogMode` values (shows error and valid options).

---

## Output

- **Log files**: CSV files listing all folders (and optionally files) backed up.
- **Backup**: Copies source folder contents to the destination, preserving structure.

---

## Logging Modes

- **FoldersOnly**: Logs only folder names.
- **FoldersAndFiles**: Logs both folders and files.

---

## Example Output

See [logging-examples/logging-folders-and-files/BACKUP.csv](logging-examples/logging-folders-and-files/BACKUP.csv) and [logging-examples/logging-folders-only/BACKUP.csv](logging-examples/logging-folders-only/BACKUP.csv) for sample log outputs.

---

## Notes

- The param block is at the top of the PowerShell script for compatibility.
- Batch file passes parameters in the correct order and with correct names.
- All scripts are tested with PowerShell 5 and 7.

---
