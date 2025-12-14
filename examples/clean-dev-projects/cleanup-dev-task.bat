:: -------------------------------------------------------------------------------
:: cleanup-dev-task.bat
::
:: SYNOPSIS
::     Batch file to run the PowerShell cleanup-dev.ps1 script for cleaning dev project folders.
::
:: USAGE
::     cleanup-dev-task.bat [SearchPath] [FoldersOnly|FoldersAndFiles]
::
:: PARAMETERS
::     SearchPath      - The root directory to clean (default: C:\SOURCE-ACTIVE-DIV).
::     LogMode         - "FoldersOnly" logs only deleted folders, "FoldersAndFiles" logs both folders and files (default: FoldersAndFiles).
::
:: EXAMPLES
::     cleanup-dev-task.bat
::     cleanup-dev-task.bat D:\Projects FoldersOnly
::     cleanup-dev-task.bat "C:\My Projects" FoldersAndFiles
::
:: DESCRIPTION
::     Calls cleanup-dev.ps1 to recursively delete folders named 'node_modules', 'www', 'dist', or '.angular'
::     in the specified directory and logs deletions to a CSV file.
:: -------------------------------------------------------------------------------

REM @echo off
REM Batch file to run the PowerShell cleanup script

REM Usage: cleanup-dev-task.bat [SearchPath][FoldersOnly|FoldersAndFiles]
set "SearchPath=C:\SOURCE-ACTIVE-DIV"
set LogMode=%2

if not "%~1"=="" (
    set "SearchPath=%~1"
    REM Remove trailing backslash if exists
    if not "!SearchPath!"=="" ^
        if "!SearchPath:~-1!"=="\" ^
            set "SearchPath=!SearchPath:~0,-1!"
)

IF "%LogMode%"=="" SET LogMode=FoldersAndFiles
"C:\Program Files\PowerShell\7\pwsh.exe" -NoProfile -ExecutionPolicy Bypass -File "C:\SOURCE-ACTIVE\backup-scripts\examples\clean-dev-projects\cleanup-dev.ps1" -source %SearchPath% -LogMode %LogMode%