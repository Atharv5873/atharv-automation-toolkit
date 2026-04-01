# ⚡ PowerShell Automation for Claude-Mem (Windows)

This module provides a PowerShell-based CLI interface to manage the Claude-Mem plugin worker service on Windows systems.

---

## 🧠 What is Claude-Mem?

Claude-Mem is a persistent memory compression system for Claude Code that enables:

- **Context persistence across sessions** — Retain session state between interactions
- **Automatic logging of tool usage and observations** — Track all actions and insights
- **Semantic summarization of session activity** — Compress information intelligently
- **Searchable historical context** — Query past sessions using SQLite + FTS5 (Full-Text Search)

It runs a background worker service responsible for processing, compressing, and storing memory data.

---

## 🎯 Purpose of This Tool

Managing the Claude-Mem worker manually requires:
1. Navigating to the Claude-Mem plugin directory
2. Running npm scripts in the correct context
3. Managing the worker service lifecycle

This tool simplifies that workflow by exposing a clean CLI-style interface:

```powershell
claude-mem start     # Start memory worker
claude-mem stop      # Stop worker
claude-mem status    # Check worker status
```

---

## ⚙️ How It Works

- **PowerShell Function Wrapper** — Acts as a lightweight CLI interface
- **Directory Context Management** — Uses `Push-Location` and `Pop-Location` to preserve your current working directory
- **npm Script Execution** — Directly executes npm scripts within the Claude-Mem plugin directory
- **Local Control Layer** — Provides simple access to the Claude-Mem worker process without manual navigation

### Script Flow

```
User Command
    ↓
PowerShell Function (claude-mem)
    ↓
Push to plugin directory
    ↓
Execute npm script (worker:start/stop/status)
    ↓
Pop back to original directory
    ↓
Return to user
```

---

## 🚀 Setup Instructions

### Step 1: Open PowerShell Profile

Open your PowerShell profile in a text editor:

```powershell
notepad $PROFILE
```

If you haven't created a profile yet, you may be prompted to create one. Answer "Yes" to create it.

### Step 2: Add the Function

Copy the entire `claude-mem` function into your PowerShell profile. Here's the function:

```powershell
function claude-mem {
    param ([string]$action)

    $path = "C:\Users\athar\.claude\plugins\marketplaces\thedotmack"

    switch ($action) {
        "start" {
            Push-Location $path
            npm run worker:start
            Pop-Location
        }
        "stop" {
            Push-Location $path
            npm run worker:stop
            Pop-Location
        }
        "status" {
            Push-Location $path
            npm run worker:status
            Pop-Location
        }
        default {
            Write-Host "Usage: claude-mem start | stop | status"
        }
    }
}
```

**Important:** Adjust the `$path` variable if your Claude-Mem plugin is installed in a different location.

### Step 3: Reload PowerShell Profile

Save and close the profile file, then reload it in PowerShell:

```powershell
. $PROFILE
```

Alternatively, close and reopen PowerShell.

### Step 4: Verify Installation

Test the function by checking the status:

```powershell
claude-mem status
```

You should see output from the Claude-Mem worker status check.

---

## 📚 Usage

Once installed, use the function from any PowerShell prompt:

### Start the Claude-Mem Worker

```powershell
claude-mem start
```

This command:
- Navigates to the Claude-Mem plugin directory
- Executes `npm run worker:start`
- Returns you to your original directory

### Stop the Claude-Mem Worker

```powershell
claude-mem stop
```

This command:
- Navigates to the Claude-Mem plugin directory
- Executes `npm run worker:stop`
- Stops the running worker service

### Check Worker Status

```powershell
claude-mem status
```

This command:
- Navigates to the Claude-Mem plugin directory
- Executes `npm run worker:status`
- Displays the current status of the Claude-Mem worker

### Help/Invalid Command

```powershell
claude-mem
```

Calling the function without arguments or with an invalid action displays usage information.

---

## 🧩 Requirements

- **PowerShell 5.1+** — Windows PowerShell or PowerShell 7+
- **Node.js v18+** — For running npm scripts
- **Claude Code** — With plugin support enabled
- **Claude-Mem Plugin** — Installed in the configured directory
- **npm Scripts** — The plugin must expose these scripts:
  - `worker:start` — Starts the worker service
  - `worker:stop` — Stops the worker service
  - `worker:status` — Reports worker status

### Verify Requirements

Check your versions:

```powershell
# PowerShell version
$PSVersionTable.PSVersion

# Node.js version
node --version

# npm version
npm --version
```

