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
