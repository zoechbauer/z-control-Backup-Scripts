:: -------------------------------------------------------------------------------
:: backup-dev-task.bat
::
:: SYNOPSIS
::     Batch file to run the PowerShell backup-dev.ps1 script for backup dev project folders.
::
:: USAGE
::     backup-dev-task.bat [SourcePath] [DestinationPath] [FoldersOnly|FoldersAndFiles] [LogFilePath]
::
:: PARAMETERS
::     SourcePath      - The root directory to back up (default: C:\SOURCE-ACTIVE-DIV).
::     DestinationPath - The final backup destination (default: C:\Users\hansz\OneDrive\Dokumente\SOURCE-ACTIVE).
::     LogMode         - "FoldersOnly" logs only folders, "FoldersAndFiles" logs both folders and files (default: FoldersAndFiles).
::     LogFilePath     - Path to the CSV log file (default: BACKUP.csv in the script directory).
::
:: EXAMPLES
::     backup-dev-task.bat
::     backup-dev-task.bat D:\Projects D:\Backup FoldersOnly
::     backup-dev-task.bat "C:\My Projects" "D:\My Backup" FoldersAndFiles "C:\Logs\backup-log.csv"
::
:: DESCRIPTION
::     Calls backup-dev.ps1 to recursively delete folders named 'node_modules', 'www', 'dist', or '.angular'
::     in the specified directory and logs deletions to a CSV file.
:: -------------------------------------------------------------------------------

@echo off
REM Batch file to run the PowerShell cleanup script
setlocal EnableDelayedExpansion

REM Usage: backup-dev-task.bat [SourcePath] [DestinationPath] [FoldersOnly|FoldersAndFiles] [LogFilePath]
set "SourcePath=C:\SOURCE-ACTIVE-DIV"
set "DestinationPath=C:\Users\hansz\OneDrive\Dokumente\SOURCE-ACTIVE"
set "LogMode=FoldersAndFiles"
set "LogFilePath=%~dp0BACKUP.csv"                  REM Default: script directory
set "PSScriptPath=%~dp0backup-dev.ps1"             REM Path to PowerShell script

if not "%~1"=="" (
    set "SourcePath=%~1"
    REM Remove trailing backslash if exists
    if not "!SourcePath!"=="" if "!SourcePath:~-1!"=="\" set "SourcePath=!SourcePath:~0,-1!"
)

if not "%~2"=="" (
    set "DestinationPath=%~2"
    REM Remove trailing backslash if exists
    if not "!DestinationPath!"=="" if "!DestinationPath:~-1!"=="\" set "DestinationPath=!DestinationPath:~0,-1!"
)

if not "%~3"=="" (
    set "LogMode=%~3"
)

if not "%~4"=="" (
    set "LogFilePath=%~4"
    REM Remove trailing backslash if exists
    if not "!LogFilePath!"=="" (
        if "!LogFilePath:~-1!"=="\" (
            set "LogFilePath=!LogFilePath:~0,-1!"
        )
    )
)

echo Starting backup-dev.ps1
echo          SourcePath:      "!SourcePath!"
echo          DestinationPath: "!DestinationPath!"
echo          LogMode:         "!LogMode!"
echo          LogFilePath:     "!LogFilePath!"
echo          PSScriptPath:    "!PSScriptPath!"

"C:\Program Files\PowerShell\7\pwsh.exe" -NoProfile -ExecutionPolicy Bypass -File "!PSScriptPath!" -Source "!SourcePath!" -BackupDest "!DestinationPath!" -LogMode "!LogMode!" -LogFile "!LogFilePath!"