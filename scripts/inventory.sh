#!/bin/bash
# ======================================================
# inventory.sh - Server Inventory script
# Author: Mohammad Maaz
# Description: Collect System Information
# ======================================================

echo ""
echo "==================================================="
echo "                  SERVER INVENTORY"
echo "                      $(date)"
echo "==================================================="
echo ""

# System Information
echo "==== SYSTEM INFORMATION ===="
echo "Hostname     :$(hostname)"
echo "Username     :$(whoami)"
echo "OS           :$(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
echo "Kernel Version :$(uname -r)"
echo "Uptime         :$(uptime -p)"
echo ""

# Disk Usage 
echo "==== Disk Usage ===="
df -h | grep "^/dev"
echo ""

# Memory Usage
echo "==== MEMORY USAGE ===="
free -h | grep "Mem"
echo ""

# Network Information
echo "==== NETWORK INFORMATION ===="
ip addr show | grep "inet" | grep -v "127.0.0.1"
echo ""

# Top 5 process by memory
echo "==== TOP 5 MEMORY PROCESS ===="
ps -eo pid,pmem,comm --sort=-pmem --no-headers | head -5
echo ""

# Logged in user
echo "==== LOGGED IN USER ===="
who
echo ""

# Last 5 system error
journalctl -n 50 2>/dev/null | grep -i "error" | tail -5 || echo "No errors found"
echo ""

echo "============================================="
echo "      INVENTORY REPORT COMPLETE"
echo "============================================="
echo ""
