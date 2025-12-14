<#
.SYNOPSIS
    Recursively cleans up all content from $source by removing folders named 'node_modules', 'www', 'dist', or '.angular' at any depth.
    Each deleted folder and (optionally) its files are logged to $logFile (CSV) with timestamp;name;type;directory;deleted;fullpath.

.DESCRIPTION
    This script searches the specified $source directory and all its subdirectories for folders named 'node_modules', 'www', 'dist', or '.angular'.
    When such a folder is found, it is deleted. Each deleted folder is logged to the CSV log file.
    If LogMode is "FoldersAndFiles", all files within deleted folders are also logged.
    The log file is always overwritten at the start of each run.

.PARAMETER source
    The root directory to clean. All subfolders are processed recursively.

.PARAMETER logFile
    Path to the CSV log file. The file will be overwritten on each run.

.PARAMETER LogMode
    Controls logging:
        "FoldersOnly"      - Only deleted folders are logged.
        "FoldersAndFiles"  - Both deleted folders and all files within them are logged.

.EXAMPLE
    .\cleanup-dev.ps1 -source "C:\Projects" -LogMode "FoldersOnly"
    .\cleanup-dev.ps1 -source "C:\Projects" -LogMode "FoldersAndFiles"

.NOTES
    - Only folders with exact names in the $deleteFolders array are deleted.
    - Logging includes: timestamp, name, type, directory, deleted, full path.
    - Requires PowerShell 5 or later.
#>

param(
    [string]$source = "C:\SOURCE-ACTIVE-DIV",
    [string]$logFile = "C:\SOURCE-ACTIVE\backup-scripts\examples\clean-dev-projects\CLEANUP.csv",
    [ValidateSet("FoldersOnly", "FoldersAndFiles")]
    [string]$LogMode = "FoldersAndFiles"
)

# Always overwrite log file with header
"Timestamp;Name;Type;Directory;Deleted;Full Path" | Out-File $logFile

# Function to log processed items
function Write-CleanupItemLog {
    param (
        [string]$name,
        [string]$type,
        [string]$directory,
        [string]$deleted,
        [string]$fullpath
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp;$name;$type;$directory;$deleted;$fullpath" | Out-File $logFile -Append
}

# Folders to delete
$deleteFolders = @(".angular", "node_modules", "www", "dist")

# Recursive cleanup function
function Cleanup-ItemRecursive {
    param (
        [string]$path
    )
    Get-ChildItem -Path $path -Force | ForEach-Object {
        $item = $_
        if ($item.PSIsContainer) {
            if ($deleteFolders -contains $item.Name) {
                # Delete folder and log
                try {
                    if ($LogMode -eq "FoldersAndFiles") {
                        # Log all files that were inside the deleted folder
                        Get-ChildItem -Path $item.FullName -Recurse -File -Force -ErrorAction SilentlyContinue | ForEach-Object {
                            Write-CleanupItemLog -name $_.Name -type "File" -directory (Split-Path $_.FullName -Parent) -deleted "true" -fullpath $_.FullName
                        }
                    }
                    Write-CleanupItemLog -name $item.Name -type "Folder" -directory (Split-Path $item.FullName -Parent) -deleted "true" -fullpath $item.FullName
                    Remove-Item -Path $item.FullName -Recurse -Force
                } catch {
                    Write-Host "Failed to delete $($item.FullName): $_"
                }
            } else {
                # Recurse into subfolder
                Cleanup-ItemRecursive -path $item.FullName
            }
        }
    }
}

# Start recursive cleanup
Cleanup-ItemRecursive -path $source

Write-Host "Cleanup complete. All deleted items logged to $logFile"