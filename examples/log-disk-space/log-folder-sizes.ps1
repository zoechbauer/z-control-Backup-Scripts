<#
.SYNOPSIS
    Logs the sizes of folders under a specified path to CSV and TXT files.

.DESCRIPTION
    Processes folders under $SearchPath. If $SearchDepth is greater than 0 or -1, includes subfolders up to $SearchDepth.
    If $SearchDepth is -1, all subfolders are processed recursively.
    Results are saved to $LogFile (TXT) and $CsvFile (CSV).

.PARAMETER SearchPath
    The root directory to scan (default: C:\SOURCE-ACTIVE).

.PARAMETER SearchDepth
    Depth for subfolder search (0 = top-level only, -1 = unlimited).

.PARAMETER LogFile
    Path to the CSV log file. The file will be overwritten on each run.

.EXAMPLE
    .\log-folder-sizes.ps1 -SearchPath "C:\SOURCE-ACTIVE" -SearchDepth 3 -LogFile "C:\Logs\FolderSizesLog.csv"
    .\log-folder-sizes.ps1 -SearchPath "C:\SOURCE-ACTIVE" -SearchDepth -1 -LogFile "C:\Logs\FolderSizesLog.csv"
    .\log-folder-sizes.ps1

.NOTES
    Compatible with PowerShell 5 and 7.
#>

param(
    [string]$SearchPath = "C:\SOURCE-ACTIVE",
	[int]$SearchDepth = 0,
    [string]$LogFile = "C:\SOURCE-ACTIVE\backup-scripts\examples\log-disk-space\FolderSizesLog.csv"
)

Write-Host "Running log-folder-sizes.ps1"
Write-Host "        SearchPath:         $SearchPath"
Write-Host "        SearchDepth:        $SearchDepth  (-1 for unlimited)"
Write-Host "        Log file:           $LogFile"

# Add trailing backslash to root paths like C:\
if ($SearchPath.Length -eq 2 -and $SearchPath[1] -eq ":") {
    $SearchPath = "$SearchPath\"
}

# Clear log files and add headers
"Folder;Size_MB;Access_Denied" | Out-File -FilePath $LogFile

# Determine if subfolders should be included
$IncludeSubfolders = ($SearchDepth -ne 0)

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
    "$folderPath;$sizeMB;$Access_Denied" | Out-File -FilePath $LogFile -Append
}

Write-Host "Results saved to:"
Write-Host $LogFile