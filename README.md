# z-control Backup Scripts 🚀

Welcome to the **z-control Backup Scripts** repository!  
This project provides a collection of PowerShell and batch scripts to automate and streamline the backup process for development environments and to log disk space usage.  
Whether you need to back up your code, configurations, or other important files, or monitor and analyze disk usage across your projects, these scripts provide a robust and flexible foundation.

> **Note:**  
While most projects are committed to GitHub or another backup service, these scripts are especially useful for simple tests, examples, or temporary projects. They help you remove unwanted large folders (such as dependencies and build outputs), copy a lean version of your projects to a folder synchronized with a service like OneDrive, and audit disk space usage.

---

## 📁 Project Structure

```
backup-scripts/
│
├── README.md
├── LICENSE
│
├── docs/
│   ├── Backup Scripts for Development Projects.md
│   ├── Backup Scripts for non committed files.md
│   ├── Log Disk Space Scripts.md
│   └── Upgrade PowerShell 5 to 7.md
│
├── examples/
│   ├── README.md
│   ├── backup-dev-projects/
│   │   ├── backup-script/
│   │   │   ├── backup-dev.ps1
│   │   │   ├── backup-dev-task.bat
│   │   │   ├── README.md
│   │   │   ├── logging-folders-and-files/
│   │   │   │   ├── BACKUP.csv
│   │   │   │   └── BACKUP.xlsx
│   │   │   ├── logging-folders-only/
│   │   │   │   ├── BACKUP.csv
│   │   │   │   └── BACKUP.xlsx
│   │   └── backup-non-committed-dev-projects/
│   │       ├── backup-dev-div.ps1
│   │       ├── backup-dev-div-task.bat
│   │       └── README.md
│   ├── backup-non-committed-project-files/
│   │   ├── calculator/
│   │   │   └── tools/
│   │   │       ├── backup_non_committed_files.ps1
│   │   │       ├── backup_non_committed_files.txt
│   │   │       └── README.md
│   │   └── z-control landing-page/
│   │       └── tools/
│   │           ├── backup_non_committed_files.ps1
│   │           ├── backup_non_committed_files.txt
│   │           └── README.md
│   ├── log-disk-space/
│   │   ├── README.md
│   │   ├── log-folder-sizes.bat
│   │   ├── log-folder-sizes.ps1
│   │   ├── example-one-project-unlimited-subfolders/
│   │   │   ├── terminal-log.txt
│   │   │   ├── FolderSizesLog.csv
│   │   │   ├── FolderSizesLog.txt
│   │   │   └── FolderSizesLog.xlsx
│   │   └── example-source-active-searchDepth-2/
│   │       ├── terminal-log.txt
│   │       ├── FolderSizesLog.csv
│   │       ├── FolderSizesLog.txt
│   │       └── FolderSizesLog.xlsx
```

## 🚀 Getting Started

### Prerequisites

- **Microsoft PowerShell** (Windows)
- Optionally, Windows Task Scheduler for automated backups

### Installation

```bash
# Clone the repository
git clone https://github.com/zoechbauer/backup-scripts.git
cd backup-scripts

# Create a scheduled task or run scripts manually
```

## 🛠️ Tech Stack

- **Microsoft PowerShell**: Primary scripting language
- **Batch Scripting**: For Windows task automation

## 📖 Documentation

All documentation lives in [`docs/`](docs/):

- [Backup Scripts for Development Projects](docs/Backup%20Scripts%20for%20Development%20Projects.md):  
  Guide for backing up entire development projects, especially Angular and IONIC projects.  
  Includes usage of `backup-dev.ps1` and `backup-dev-task.bat`, logging options, and customization for excluded folders.

- [Backup Scripts for non committed files](docs/Backup%20Scripts%20for%20non%20committed%20files.md):  
  Guide for backing up files and folders not typically committed to version control (e.g., `.github`, `.vscode`, `.env.local`).  
  Includes usage for example projects like Calculator and z-control landing-page.

- [Log Disk Space Scripts](docs/Log%20Disk%20Space%20Scripts.md):  
  Guide for logging disk space usage, including usage instructions, script details, and example outputs.

- [Upgrade PowerShell 5 to 7](docs/Upgrade%20PowerShell%205%20to%207.md):  
  Step-by-step instructions for upgrading from Windows PowerShell 5.1 to PowerShell 7, including integration with VS Code and scheduled tasks.

## 📝 Features

- Recursively back up project folders and files
- Exclude common build and dependency folders (customizable)
- Log processed items to CSV (folders only or folders and files)
- Example scripts for non-committed files
- Ready for scheduled automation via batch files
- **Log disk space usage** for any disk drive or directory, with flexible depth and output formats (TXT, CSV, Excel-ready)
- Example logs and Excel files for disk usage analysis

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 📧 Contact

**Hans Zöchbauer**

- Email: [hans.zoechbauer@gmail.com](mailto:hans.zoechbauer@gmail.com)
- GitHub: [zoechbauer](https://github.com/zoechbauer)

If you have questions, need support, or want to contribute, feel free to reach out via email or open an issue on GitHub.

---

_Last Updated: December 13, 2025_