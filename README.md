# Atharv Automation Toolkit

Welcome to **Atharv Automation Toolkit** — my personal collection of **custom Bash scripts** built to automate and simplify everyday **Linux system administration** and **DevOps** tasks.

This is a **continuous project** where I keep adding scripts that I personally use to speed up my workflow, manage servers, and explore system automation.

---

## About

Each script in this repository is designed with:
- ✅ Safe and reliable Bash practices (`set -euo pipefail`)
- 🎨 Clean, color-coded output
- 🧩 Modular functions and easy readability
- 💬 Inline comments and documentation

Whether it’s restarting a service safely, monitoring resource usage, or automating configuration — every script is built from real-world use.

---

## Repository Structure
```
atharv-automation-toolkit/
│
├── system/
│   ├── reload_ssh_config.sh   # Safely tests and reloads SSH config
│   └── adminx.sh              # Interactive system admin menu tool
│
├── aliases/
│ ├── personal_aliases.sh
│
├── monitoring/
│ └── (coming soon)
│
├── maintenance/
│ └── (coming soon)
│
└── README.md
```

---

## Getting Started

Clone the repository:
```bash
git clone https://github.com/atharv-sharma/atharv-automation-toolkit.git
cd atharv-automation-toolkit
```

If you plan to use these scripts frequently, you can **add the toolkit directory to your system PATH** so you can run the tools from anywhere in your terminal.
```bash
echo 'export PATH="$PATH:$HOME/atharv-automation-toolkit/system"' >> ~/.bashrc
source ~/.bashrc
```
Now you can run your scripts globally like:
```
reaload-ssh.sh
```
---
## 🧠 Personal Aliases

This toolkit also includes a set of **custom Bash aliases** I use for faster system administration.

To use them:
```bash
source ~/atharv-automation-toolkit/aliases/personal_aliases.sh
```

---
## Contributions
This project is primarily for personal use, but ideas, improvements, and suggestions are welcome!
Feel free to open an issue or pull request if you have something valuable to add.
