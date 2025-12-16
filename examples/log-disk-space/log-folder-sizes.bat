:: -----------------------------------------------------------------------------
:: log-folder-sizes.bat
::
:: SYNOPSIS
::     Runs a PowerShell script to log folder sizes for a specified path.
::
:: USAGE
::     log-folder-sizes.bat [SearchPath] [SearchDepth] [LogFilePath]
::
:: PARAMETERS
::     SearchPath   - The root directory or drive to scan (default: C:\SOURCE-ACTIVE).
::     SearchDepth  - Depth for subfolder search (0 = top-level only, -1 = unlimited).
::     LogFilePath  - Path to the CSV log file (default: FolderSizesLog.csv in the script directory).
::
:: EXAMPLES
::     log-folder-sizes.bat
::     log-folder-sizes.bat "C:\SOURCE INVALID" 3 "C:\Logs\FolderSizesLog.csv"
::     log-folder-sizes.bat C:\SOURCE-ACTIVE -1 "C:\Logs\FolderSizesLog.csv"
::     log-folder-sizes.bat C: 3 "C:\Logs\FolderSizesLog.csv"
::
:: DESCRIPTION
::     Calls log-folder-sizes.ps1 to log folder sizes to CSV and TXT files.
:: -----------------------------------------------------------------------------

@echo off
setlocal EnableDelayedExpansion
REM Usage:
REM log-folder-sizes.bat C:\SOURCE-ACTIVE        -> log only top-level folders (=default)
REM log-folder-sizes.bat C:\SOURCE-ACTIVE 3      -> log all folders and subfolders up to depth 3
REM log-folder-sizes.bat "C:\SOURCE INVALID" 3   -> folder name with special character
REM log-folder-sizes.bat C:\SOURCE-ACTIVE -1     -> log all folders and subfolders with unlimited depth
REM log-folder-sizes.bat C: 3                    -> log all folders and subfolders of drive C: up to depth 3

set "SearchPath=C:\SOURCE-ACTIVE"
set "SearchDepth=0"
set "LogFilePath=%~dp0FolderSizesLog.csv"                REM Default: script directory
set "PSScriptPath=%~dp0log-folder-sizes.ps1"             REM Path to PowerShell script

if not "%~1"=="" (
    set "SearchPath=%~1"
    REM Remove trailing backslash if exists
    if not "!SearchPath!"=="" if "!SearchPath:~-1!"=="\" set "SearchPath=!SearchPath:~0,-1!"
)

if not "%~2"=="" (
    set "SearchDepth=%~2"
)

if not "%~3"=="" (
    set "LogFilePath=%~3"
    REM Remove trailing backslash if exists
    if not "!LogFilePath!"=="" if "!LogFilePath:~-1!"=="\" set "LogFilePath=!LogFilePath:~0,-1!"
)

echo Starting log-folder-sizes.ps1
echo          SearchPath:        !SearchPath!
echo          SearchDepth:       !SearchDepth!
echo          LogFile:           !LogFilePath!
echo          PSScriptPath:      !PSScriptPath!

REM Call the PowerShell script with parameters for problematic params
"C:\Program Files\PowerShell\7\pwsh.exe" -NoProfile -ExecutionPolicy Bypass -File "%PSScriptPath%" -SearchPath "!SearchPath!" -SearchDepth !SearchDepth! -LogFile "!LogFilePath!"