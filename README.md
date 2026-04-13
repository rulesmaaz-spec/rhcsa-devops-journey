# RHCSA to DevOps Journey

## About This Repository
This repository documents my journey BCA from RHCSA certification and to becoming a DevOps Engineer.

## Day 1: Linux Fundamentals

### Scripts Created

#### 1. system_report.sh
Basic system health report script that shows:
- System information
- Disk usage
- Memory usage
- Top CPU processes

#### 2. inventory.sh
Professional server inventory script that collects:
- System information (hostname, OS, kernel, uptime)
- Disk usage
- Memory usage  
- Network information
- Top memory processes
- Logged in users
- Recent system errors

### Skills Learned
- Linux navigation commands (`pwd`, `ls`, `cd`)
- File operations (`touch`, `mkdir`, `cp`, `mv`, `rm`)
- Redirection (`>`, `>>`, `|`)
- Text searching with `grep`
- Bash scripting basics
- Git and GitHub

## How to Run
```bash
cd ~/rhcsa-lab/scripts
./system_report.sh
./inventory.sh
