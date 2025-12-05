<#
.SYNOPSIS
    Recursively backs up all content from $source to $backupDest, excluding folders named 'node_modules', 'www', 'dist', or '.angular' at any depth.
    Folders and files are copied directly to $backupDest.
    Each processed item is logged to $logFile (CSV) with timestamp;name;type;directory;fullpath.

.PARAMETER source
    The root directory to back up.

.PARAMETER backupDest
    Final backup destination.

.PARAMETER logFile
    Path to the CSV log file.

.PARAMETER LogMode
    Controls logging: "FoldersOnly" logs only folders, "FoldersAndFiles" logs both folders and files.
#>

param(
    [string]$source = "C:\SOURCE-ACTIVE-DIV",
    [string]$backupDest = "C:\Users\hansz\OneDrive\Dokumente\SOURCE-ACTIVE-DIV",
    [string]$logFile = "C:\Users\hansz\OneDrive\Dokumente\SOURCE-ACTIVE-DIV\BACKUP.csv",
    [ValidateSet("FoldersOnly", "FoldersAndFiles")]
    [string]$LogMode = "FoldersAndFiles"
)

# Create backup destination if it doesn't exist
if (!(Test-Path $backupDest)) {
    New-Item -ItemType Directory -Path $backupDest | Out-Null
}

# Always overwrite log file with header
"Timestamp;Name;Type;Directory;Full Path" | Out-File $logFile

# Function to log processed items
function Write-BackupItemLog {
    param (
        [string]$name,
        [string]$type,
        [string]$directory,
        [string]$fullpath
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp;$name;$type;$directory;$fullpath" | Out-File $logFile -Append
}

# Excluded folder names
$excludeFolders = @(".angular", "node_modules", "www", "dist")

# Recursive copy function
function Copy-ItemRecursive {
    param (
        [string]$src,
        [string]$dest
    )
    Get-ChildItem -Path $src | ForEach-Object {
        $item = $_
        $relativePath = $item.FullName.Substring($source.Length).TrimStart('\')
        $destPath = Join-Path $backupDest $relativePath

        if ($item.PSIsContainer) {
            if ($excludeFolders -contains $item.Name) {
                return
            }
            if (!(Test-Path $destPath)) {
                New-Item -ItemType Directory -Path $destPath | Out-Null
            }
            Write-BackupItemLog -name $item.Name -type "Folder" -directory (Split-Path $item.FullName -Parent) -fullpath $item.FullName
            # Recurse into subfolder
            Copy-ItemRecursive -src $item.FullName -dest $destPath
        } else {
            $destFileDir = Split-Path $destPath -Parent
            if (!(Test-Path $destFileDir)) {
                New-Item -ItemType Directory -Path $destFileDir -Force | Out-Null
            }
            Copy-Item -Path $item.FullName -Destination $destPath -Force

            if ($LogMode -eq "FoldersAndFiles") {
                # Log all files
                $parentFolder = Split-Path $item.FullName -Parent
                Write-BackupItemLog -name $item.Name -type "File" -directory $parentFolder -fullpath $item.FullName
            }
            # If FoldersOnly, do not log files
        }
    }
}

# Start recursive copy
Copy-ItemRecursive -src $source -dest $backupDest

Write-Host "Backup complete. All items processed and logged to $logFile"