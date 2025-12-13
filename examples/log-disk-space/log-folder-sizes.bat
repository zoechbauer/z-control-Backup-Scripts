:: -----------------------------------------------------------------------------
:: log-folder-sizes.bat
::
:: SYNOPSIS
::     Runs a PowerShell script to log folder sizes for a specified path.
::
:: USAGE
::     log-folder-sizes.bat [SearchPath] [subfolders] [SearchDepth]
::
:: PARAMETERS
::     SearchPath   - The root directory or drive to scan (default: C:\SOURCE-ACTIVE).
::     subfolders   - If specified, includes subfolders up to SearchDepth.
::     SearchDepth  - Depth for subfolder search (0 = top-level only, -1 = unlimited).
::
:: EXAMPLES
::     log-folder-sizes.bat
::     log-folder-sizes.bat "C:\SOURCE INVALID" subfolders 3
::     log-folder-sizes.bat C:\SOURCE-ACTIVE subfolders -1
::     log-folder-sizes.bat C: subfolders 3
::
:: DESCRIPTION
::     Calls log-folder-sizes.ps1 to log folder sizes to CSV and TXT files.
:: -----------------------------------------------------------------------------

@echo off
setlocal EnableDelayedExpansion
REM Usage:
REM log-folder-sizes.bat C:\SOURCE-ACTIVE               	-> log only top-level folders (=default)
REM log-folder-sizes.bat C:\SOURCE-ACTIVE subfolders 3      -> log all folders and subfolders up to depth 3
REM log-folder-sizes.bat "C:\SOURCE INVALID" subfolders 3   -> folder name with special character
REM log-folder-sizes.bat C:\SOURCE-ACTIVE subfolders -1     -> log all folders and subfolders with unlimited depth
REM log-folder-sizes.bat C: subfolders 3                    -> log all folders and subfolders of drive C: up to depth 3

set "SearchPath=C:\SOURCE-ACTIVE"
set "SearchDepth=0"
set "ScriptPath=C:\SOURCE-ACTIVE\backup-scripts\examples\log-disk-space"
set "IncludeSubfolders=false"

if not "%~1"=="" (
    set "SearchPath=%~1"
    REM Remove trailing backslash if exists
    if not "!SearchPath!"=="" ^
        if "!SearchPath:~-1!"=="\" ^
            set "SearchPath=!SearchPath:~0,-1!"

)

if /I "%~2"=="subfolders" (
    set "IncludeSubfolders=true"
    if not "%~3"=="" set "SearchDepth=%~3"
)

echo Parameters for PowerShell script:
echo     SearchPath: !SearchPath!
echo     IncludeSubfolders: !IncludeSubfolders!
echo     SearchDepth: !SearchDepth!

REM Call the PowerShell script with parameters for problematic params
"C:\Program Files\PowerShell\7\pwsh.exe" -NoProfile -ExecutionPolicy Bypass -File "%ScriptPath%\log-folder-sizes.ps1" -SearchPath "!SearchPath!" -SearchDepth !SearchDepth! -ScriptPath "!ScriptPath!" -IncludeSubfolders !IncludeSubfolders!

pause