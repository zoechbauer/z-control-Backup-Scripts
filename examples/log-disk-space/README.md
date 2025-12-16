# Log Disk Space

This folder contains scripts to log the sizes of folders within a specified directory or disk drive. These tools are useful for monitoring disk usage, auditing project storage, and identifying large folders.

## Files

- **log-folder-sizes.bat**  
  Batch file to launch the PowerShell script for logging folder sizes.  
  Supports specifying the root path, search depth (including unlimited depth), and log file location.

- **log-folder-sizes.ps1**  
  PowerShell script that scans the specified directory or disk drive and logs the size of each folder (and optionally subfolders) to a CSV file.  
  Handles access errors gracefully and supports both PowerShell 5 and 7.

## Usage

1. Open a terminal in this directory.
2. Run the batch file with your desired parameters:
   ```
   log-folder-sizes.bat [SearchPath] [SearchDepth] [LogFilePath]
   ```
   - **SearchPath**: The root directory or drive to scan (default: `C:\SOURCE-ACTIVE`).
   - **SearchDepth**: Depth for subfolder search (`0` = top-level only, `-1` = unlimited, any other positive number = that depth).
   - **LogFilePath**: Path to the CSV log file (default: `FolderSizesLog.csv` in the script directory).

   **Examples:**
   ```
   log-folder-sizes.bat
   log-folder-sizes.bat C:\SOURCE-ACTIVE 3
   log-folder-sizes.bat C:\SOURCE-ACTIVE -1
   log-folder-sizes.bat C: 3 "C:\Logs\FolderSizesLog.csv"
   ```

3. The results will be saved to:
   - `FolderSizesLog.csv` (semicolon-separated)

## Script Details

### log-folder-sizes.bat

- Calls PowerShell 7 (`pwsh.exe`) to run the logging script.
- Accepts parameters for the search path, search depth, and log file location.
- Example usage is included in the comments at the top of the file.

### log-folder-sizes.ps1

- Scans the specified directory or disk drive and logs the size of each folder.
- Subfolder inclusion is determined by the `SearchDepth` parameter:
  - `0` = only top-level folders
  - `-1` = unlimited depth (all subfolders)
  - Any other positive number = that depth
- Handles access-denied errors and logs them accordingly.
- Outputs results to a CSV file for easy review and further processing.
- Compatible with both PowerShell 5 and 7.

## Example Folders

This folder also contains 2 example folders.  
Each example folder includes:
- `terminal-log.txt`: Shows the used parameters for the script run.
- `FolderSizesLog.csv`: The resulting logs in CSV format.
- An Excel file: Contains the imported CSV data, sorted descending by size.

These examples demonstrate how to use the scripts and how to process and analyze the results.

## Notes

- You can adjust the default search path and other parameters by editing the batch file.
- For unlimited recursive scanning, use `-1` as the search depth.
- Do not add a trailing backslash to the root path (e.g., use `C:` or `C:\SOURCE-ACTIVE`).
- Make sure you have permission to access all folders you want to scan.
- The scripts are designed to be robust and informative, making it easy to monitor disk usage across your projects.