# Log Disk Space

This folder contains scripts to log the sizes of folders within a specified directory or disk drive. These tools are useful for monitoring disk usage, auditing project storage, and identifying large folders.

## Files

- **log-folder-sizes.bat**  
  Batch file to launch the PowerShell script for logging folder sizes.  
  Supports specifying the root path, whether to include subfolders, and the search depth (including unlimited depth).

- **log-folder-sizes.ps1**  
  PowerShell script that scans the specified directory or disk drive and logs the size of each folder (and optionally subfolders) to both a CSV and a TXT file.  
  Handles access errors gracefully and supports both PowerShell 5 and 7.

## Usage

1. Open a terminal in this directory.
2. Run the batch file with your desired parameters:
   ```
   log-folder-sizes.bat [SearchPath] [subfolders] [SearchDepth]
   ```
   - **SearchPath**: The root directory or drive to scan (default: `C:\SOURCE-ACTIVE`).
   - **subfolders**: If specified, includes subfolders up to the given depth.
   - **SearchDepth**: Depth for subfolder search (`0` = top-level only, `-1` = unlimited).

   **Examples:**
   ```
   log-folder-sizes.bat
   log-folder-sizes.bat C:\SOURCE-ACTIVE subfolders 3
   log-folder-sizes.bat C:\SOURCE-ACTIVE subfolders -1
   log-folder-sizes.bat C: subfolders 3
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

- Scans the specified directory or disk drive and logs the size of each folder.
- If subfolders are included, you can specify the depth (`-1` for unlimited).
- Handles access-denied errors and logs them accordingly.
- Outputs results to both TXT and CSV files for easy review and further processing.
- Compatible with both PowerShell 5 and 7.

## Example Folders

This folder also contains 2 example folders.  
Each example folder includes:
- `terminal-log.txt`: Shows the used parameters for the script run.
- `FolderSizesLog.txt` and `FolderSizesLog.csv`: The resulting logs in TXT and CSV format.
- An Excel file: Contains the imported CSV data, sorted descending by size.

These examples demonstrate how to use the scripts and how to process and analyze the results.


## Notes

- You can adjust the default search path and other parameters by editing the batch file.
- For unlimited recursive scanning, use `subfolders -1` as parameters.
- Do not add a trailing backslash to the root path (e.g., use `C:` or `C:\SOURCE-ACTIVE`).
- Make sure you have permission to access all folders you want to scan.
- The scripts are designed to be robust and informative, making it easy to monitor disk usage across your projects.