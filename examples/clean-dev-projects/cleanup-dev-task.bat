:: -------------------------------------------------------------------------------
:: cleanup-dev-task.bat
::
:: SYNOPSIS
::     Batch file to run the PowerShell cleanup-dev.ps1 script for cleaning dev project folders.
::
:: USAGE
::     cleanup-dev-task.bat [SearchPath] [FoldersOnly|FoldersAndFiles] [LogFilePath]
::
:: PARAMETERS
::     SearchPath      - The root directory to clean (default: C:\SOURCE-ACTIVE-DIV).
::     LogMode         - "FoldersOnly" logs only deleted folders, "FoldersAndFiles" logs both folders and files (default: FoldersAndFiles).
::     LogFilePath     - Path to the CSV log file (default: CLEANUP.csv in the script directory).
::
:: EXAMPLES
::     cleanup-dev-task.bat
::     cleanup-dev-task.bat D:\Projects FoldersOnly
::     cleanup-dev-task.bat "C:\My Projects" FoldersAndFiles "C:\Logs\cleanup-log.csv"
::
:: DESCRIPTION
::     Calls cleanup-dev.ps1 to recursively delete folders named 'node_modules', 'www', 'dist', or '.angular'
::     in the specified directory and logs deletions to a CSV file.
:: -------------------------------------------------------------------------------

@echo off
REM Batch file to run the PowerShell cleanup script
setlocal EnableDelayedExpansion

REM Usage: cleanup-dev-task.bat [SearchPath] [FoldersOnly|FoldersAndFiles] [LogFilePath]
set "SearchPath=C:\SOURCE-ACTIVE-DIV"
set "LogMode=FoldersAndFiles"
set "LogFilePath=%~dp0CLEANUP.csv"                  REM Default: script directory
set "PSScriptPath=%~dp0cleanup-dev.ps1"             REM Path to PowerShell script

if not "%~1"=="" (
    set "SearchPath=%~1"
    REM Remove trailing backslash if exists
    if not "!SearchPath!"=="" if "!SearchPath:~-1!"=="\" set "SearchPath=!SearchPath:~0,-1!"
)

if not "%~2"=="" (
    set "LogMode=%~2"
)

if not "%~3"=="" (
    set "LogFilePath=%~3"
    REM Remove trailing backslash if exists
    if not "!LogFilePath!"=="" (
        if "!LogFilePath:~-1!"=="\" (
            set "LogFilePath=!LogFilePath:~0,-1!"
        )
    )
)

echo Starting cleanup-dev.ps1
echo          SearchPath:   "!SearchPath!"
echo          LogMode:      "!LogMode!"
echo          LogFilePath:  "!LogFilePath!"
echo          PSScriptPath: "!PSScriptPath!"

"C:\Program Files\PowerShell\7\pwsh.exe" -NoProfile -ExecutionPolicy Bypass -File "!PSScriptPath!" -Source "!SearchPath!" -LogMode "!LogMode!" -LogFile "!LogFilePath!"