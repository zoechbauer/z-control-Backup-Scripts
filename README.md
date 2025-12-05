# z-control Backup Scripts 🚀

Welcome to the **z-control Backup Scripts** repository! This project contains a collection of PowerShell and batch scripts designed to automate and streamline the backup process for development environments. Whether you're looking to back up your code, configurations, or other important files, these scripts provide a solid foundation to get you started.

> **Note:**  
Normally, a project is committed to GitHub or another backup service. However, for cases like simple tests, examples, or temporary projects, these scripts can help you remove unwanted large folders (such as dependencies and build outputs) and copy a lean version of your projects to a folder that is automatically synchronized with a service like OneDrive.


## 📁 Project Structure

```
backup-scripts/
│
├── README.md
├── LICENSE
│
├── docs/
│   ├── Backup Scripts for Development Projects.md
│   └── Backup Scripts for non committed files.md
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
│   │   └── calculator/
│   │       └── tools/
│   │           ├── backup_non_committed_files.ps1
│   │           ├── backup_non_committed_files.txt
│   │           └── README.md
│   └── z-control landing-page/
│       └── tools/
│           ├── backup_non_committed_files.ps1
│           ├── backup_non_committed_files.txt
│           └── README.md
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

## 📝 Features

- Recursively back up project folders and files
- Exclude common build and dependency folders (customizable)
- Log processed items to CSV (folders only or folders and files)
- Example scripts for non-committed files
- Ready for scheduled automation via batch files

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 📧 Contact

**Hans Zöchbauer**

- Email: [hans.zoechbauer@gmail.com](mailto:hans.zoechbauer@gmail.com)
- GitHub: [zoechbauer](https://github.com/zoechbauer)

If you have questions, need support, or want to contribute, feel free to reach out via email or open an issue on GitHub.

---

_Last Updated: December 5, 2025_