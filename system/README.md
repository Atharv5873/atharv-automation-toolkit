---

## Scripts Overview

### `reload-ssh.sh`
Safely tests and reloads the SSH configuration.

**Why I made it:**  
I often modify `/etc/ssh/sshd_config` while configuring servers.  
A small syntax error can lock you out of the system if you restart SSH blindly.  
This script automatically validates the SSH configuration using `sshd -t`  
and only reloads the service if the test passes — making it safer and faster.

**Key features:**
- Tests configuration before applying changes
- Works across systems with `ssh` or `sshd` service names
- Gracefully handles socket activation and daemon reloads
- Uses color-coded, readable output for clarity

### `admix.sh`
A lightweight utility to automate user and privilege management on Linux systems.

**Why I made it:**  
While setting up multiple servers or test environments, I often needed to create users,  
add them to specific groups (like `sudo`), and set up SSH access quickly.  
Manually doing this is repetitive and error-prone — so I built this script to handle it safely and consistently.

**What it does:**
- Creates a new user if it doesn’t already exist  
- Adds the user to the `sudo` group for administrative privileges  
- Sets up a home directory and default shell  
- Optionally copies SSH keys for passwordless login  
- Provides clear success/error messages for each step

**Key features:**
- Safe checks before creating users or modifying groups  
- Designed to run as root or with `sudo`  
- Uses color-coded output for visibility  
- Can be extended easily with flags or configuration variables
