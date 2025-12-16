<#
.SYNOPSIS
    Recursively backs up all content from $Source to $BackupDest, excluding folders named 'node_modules', 'www', 'dist', or '.angular' at any depth.
    Folders and files are copied directly to $BackupDest.
    Each processed item is logged to $LogFile (CSV) with timestamp;name;type;directory;fullpath.

.PARAMETER Source
    The root directory to back up.

.PARAMETER BackupDest
    Final backup destination. The directory will be created if it does not exist.
    
.PARAMETER LogMode
    Controls logging: 
    "FoldersOnly"       - logs only folders, 
    "FoldersAndFiles"   - logs both folders and files.
    
.PARAMETER LogFile
    Path to the CSV log file. The file will be overwritten on each run.

.EXAMPLE
    .\backup-dev.ps1 -Source "C:\Projects"  -BackupDest "D:\Backup" -LogMode "FoldersOnly"
    .\backup-dev.ps1 -Source "C:\Projects" -BackupDest "D:\Backup" -LogMode "FoldersAndFiles"
    .\backup-dev.ps1 -Source "C:\Projects" -BackupDest "D:\Backup" -LogMode "FoldersAndFiles" -LogFile "C:\Logs\backup-log.csv"

.NOTES
    - Only folders with exact names in the $deleteFolders array are deleted.
    - Logging includes: timestamp, name, type, directory, deleted, full path.
    - Requires PowerShell 5 or later.
#>

param(
    [string]$Source,
    [string]$BackupDest,
    [ValidateSet("FoldersOnly", "FoldersAndFiles")]
    [string]$LogMode,
    [string]$LogFile
)

$DefaultBackupDest = "C:\Users\hansz\OneDrive\Dokumente\SOURCE-ACTIVE"

if (-not $Source) { $Source = "C:\SOURCE-ACTIVE" }
if (-not $BackupDest) { $BackupDest = $DefaultBackupDest }
if (-not $LogMode) { $LogMode = "FoldersAndFiles" }
if (-not $LogFile)   { $LogFile   = Join-Path $BackupDest "BACKUP.csv" }

Write-Host "Running backup-dev.ps1"
Write-Host "        Source:     $Source"
Write-Host "        BackupDest: $BackupDest"
Write-Host "        LogMode:    $LogMode"
Write-Host "        Log file:   $LogFile"

# Create backup destination if it doesn't exist
if (!(Test-Path $BackupDest)) {
    New-Item -ItemType Directory -Path $BackupDest | Out-Null
}

# Always overwrite log file with header
"Timestamp;Name;Type;Directory;Full Path" | Out-File $LogFile

# Function to log processed items
function Write-BackupItemLog {
    param (
        [string]$name,
        [string]$type,
        [string]$directory,
        [string]$fullpath
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp;$name;$type;$directory;$fullpath" | Out-File $LogFile -Append
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
        $relativePath = $item.FullName.Substring($Source.Length).TrimStart('\')
        $destPath = Join-Path $BackupDest $relativePath

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
Copy-ItemRecursive -src $Source -dest $BackupDest

Write-Host "Backup complete. All items processed and logged to $LogFile"