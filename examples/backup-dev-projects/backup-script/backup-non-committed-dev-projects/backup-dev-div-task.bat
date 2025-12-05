REM @echo off
REM Batch file to run the PowerShell backup script

REM Usage: backup-dev-div-task.bat [FoldersOnly|FoldersAndFiles]
SET LOGMODE=%1
IF "%LOGMODE%"=="" SET LOGMODE=FoldersAndFiles
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\SOURCE-ACTIVE\backup-scripts\examples\backup-dev-projects\backup-script\backup-non-committed-dev-folder\backup-dev-div.ps1" -LogMode %LOGMODE%