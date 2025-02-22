# 🔄 Automatic Git Puller

A simple utility to automatically pull updates from multiple Git repositories in a specified directory.

⭐ Features
- 🔍 Automatic detection of Git repositories
- ⚠️ Error handling for missing directories and failed Git operations
- 💻 Support for both Windows (`.cmd`) and Unix-like (`.sh`) environments
- ⏩ Skips non-Git directories automatically

📌 Prerequisites
- Git must be installed and accessible from the command line
- Write permissions in the project directory for log creation

🛠 Setup & Installation

1️⃣ Create a `root_folder.txt` file in the project directory
2️⃣ Add the absolute path to your repositories' parent directory in `root_folder.txt`

Example `root_folder.txt`:
```plaintext
D:\MyGitProjects
```

🔨 Running Automatic Git Puller Locally

### Windows
Run the command script:
```bash
autopuller.cmd
```

### Unix-like Systems
Make the script executable and run it:
```bash
chmod +x autopuller.sh
./autopuller.sh
```

🔧 Troubleshooting
- If you see "Error: root_folder.txt not found!", make sure you've created the file and specified the correct path
- If you see "Error: Root folder does not exist!", verify that the path in root_folder.txt is correct and accessible
- For Git-related errors, check your repository's status and ensure you have proper permissions

📜 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

💡 Contributing
1. Fork the repository on GitHub (https://github.com/painteau/automatic-puller)
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to your branch (`git push origin feature-branch`)
5. Create a Pull Request

For major changes, please open an issue first to discuss the proposed modifications.

---
Maintained by [Painteau](https://github.com/painteau) | Contact: dev@gochu.fr