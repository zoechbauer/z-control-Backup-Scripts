# Log Disk Space Scripts Usage Guide

This guide explains how to use the provided PowerShell scripts to log disk space usage. These scripts help you monitor folder sizes within a specified directory, which is useful for auditing storage and identifying large folders.

## Purpose

The backup scripts are designed to:
- Scan a specified directory and log the size of each folder.
- Optionally include subfolders up to a specified depth (including unlimited depth).
- Output the results to both a CSV and a TXT file for easy review and further processing.

## Files

- **log-folder-sizes.bat**  
  Batch file to launch the PowerShell script for logging folder sizes.  
  Supports specifying the root path, whether to include subfolders, and the search depth (including unlimited depth).

- **log-folder-sizes.ps1**  
  PowerShell script that scans the specified directory and logs the size of each folder (and optionally subfolders) to both a CSV and a TXT file.  
  Handles access errors gracefully and supports both PowerShell 5 and 7.

## Usage

1. Open a terminal in this directory.
2. Run the batch file with your desired parameters:
   ```
   log-folder-sizes.bat [SearchPath] [subfolders] [SearchDepth]
   ```
   - **SearchPath**: The root directory to scan (default: `C:\SOURCE-ACTIVE`).
   - **subfolders**: If specified, includes subfolders up to the given depth.
   - **SearchDepth**: Depth for subfolder search (`0` = top-level only, `-1` = unlimited).

   **Examples:**
   ```
   log-folder-sizes.bat
   log-folder-sizes.bat C:\SOURCE-ACTIVE subfolders 3
   log-folder-sizes.bat C:\SOURCE-ACTIVE subfolders -1
   ```

3. The results will be saved to:
   - `FolderSizesLog.txt` (tab-separated)
   - `FolderSizesLog.csv` (semicolon-separated)

## Script Details

### log-folder-sizes.bat

- Calls PowerShell 7 (`pwsh.exe`) to run the logging script.
- Accepts parameters for the search path, subfolder inclusion, and search depth.
- Example usage is included in the comments at the top of the file.

### log-folder-sizes.ps1

- Scans the specified directory and logs the size of each folder.
- If subfolders are included, you can specify the depth (`-1` for unlimited).
- Handles access-denied errors and logs them accordingly.
- Outputs results to both TXT and CSV files for easy review and further processing.
- Compatible with both PowerShell 5 and 7.

## Additional Information

For more details, see the README file in log-disk-space folder:

- [examples/log-disk-space/README.md](/examples/log-disk-space/README.md)
---
_Last updated: December 12, 2025_