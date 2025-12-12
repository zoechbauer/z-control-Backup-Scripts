<#
.SYNOPSIS
    Logs the sizes of folders under a specified path to CSV and TXT files.

.DESCRIPTION
    Processes folders under $SearchPath. If $IncludeSubfolders is true, includes subfolders up to $SearchDepth.
    If $SearchDepth is -1, all subfolders are processed recursively.
    Results are saved to $LogFile (TXT) and $CsvFile (CSV).

.PARAMETER SearchPath
    The root directory to scan (default: C:\SOURCE-ACTIVE).

.PARAMETER SearchDepth
    Depth for subfolder search (0 = top-level only, -1 = unlimited).

.PARAMETER ScriptPath
    Path where log files are saved.

.PARAMETER IncludeSubfolders
    If true, includes subfolders up to SearchDepth.

.PARAMETER LogFile
    Path to the TXT log file.

.PARAMETER CsvFile
    Path to the CSV log file.

.EXAMPLE
    .\log-folder-sizes.ps1 -SearchPath "C:\SOURCE-ACTIVE" -SearchDepth 3 -IncludeSubfolders "true"
    .\log-folder-sizes.ps1 -SearchPath "C:\SOURCE-ACTIVE" -SearchDepth -1 -IncludeSubfolders "true"
    .\log-folder-sizes.ps1

.NOTES
    Compatible with PowerShell 5 and 7.
#>

param(
    [string]$SearchPath = "C:\SOURCE-ACTIVE",
	[int]$SearchDepth = 0,
    [string]$ScriptPath = "C:\SOURCE-ACTIVE\backup-scripts\examples\log-disk-space",
    [string]$IncludeSubfolders = "false",
    [string]$LogFile,
    [string]$CsvFile
)

# Force conversion of IncludeSubfolders to boolean
$IncludeSubfolders = ("$IncludeSubfolders".ToLower() -eq "$true" -or "$IncludeSubfolders".ToLower() -eq "true" -or "$IncludeSubfolders" -eq "1")

# Set default values for LogFile and CsvFile if not provided
if (-not $LogFile) { $LogFile = Join-Path $ScriptPath "FolderSizesLog.txt" }
if (-not $CsvFile) { $CsvFile = Join-Path $ScriptPath "FolderSizesLog.csv" }

Write-Host "Search Path: $SearchPath"
Write-Host "Search Depth (-1 for unlimited): $SearchDepth"
Write-Host "Script Path: $ScriptPath"
Write-Host "Include Subfolders: $IncludeSubfolders"
Write-Host "LogFile: $LogFile"
Write-Host "CsvFile: $CsvFile"

# Clear log and CSV files
"" | Out-File -FilePath $LogFile
"Folder;Size_MB;Access_Denied" | Out-File -FilePath $CsvFile

if ($IncludeSubfolders) {
    if ($SearchDepth -eq -1) {
        $folders = Get-ChildItem -Path $SearchPath -Directory -Recurse
    } else {
        $folders = Get-ChildItem -Path $SearchPath -Directory -Recurse -Depth $SearchDepth
    }
} else {
    $folders = Get-ChildItem -Path $SearchPath -Directory | Where-Object { $_.Parent.FullName -eq $SearchPath }
}

foreach ($folder in $folders) {
    $folderPath = $folder.FullName
    try {
        $size = (Get-ChildItem -Path $folderPath -Recurse -File -ErrorAction Stop | Measure-Object -Property Length -Sum).Sum
        $sizeMB = [math]::Round($size / 1MB, 2)
        $Access_Denied = ""
        $sizeMB = $sizeMB -replace '\.', ','   # Replace dot with comma for locales using comma as decimal separator
    } catch {
        $sizeMB = [math]::Round(-1.00, 2)
        $Access_Denied = "Access Denied"
    }
    "$folderPath`t$sizeMB`t$Access_Denied" | Out-File -FilePath $LogFile -Append
    "$folderPath;$sizeMB;$Access_Denied" | Out-File -FilePath $CsvFile -Append
}

Write-Host "Results saved to:"
Write-Host $LogFile
Write-Host $CsvFile