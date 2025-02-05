#!/bin/bash

echo "===== Server Performance Stats ====="

echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "User:", $2, "%  System:", $4, "%  Idle:", $8, "%"}'

echo "Memory Usage:"
free -m | awk 'NR==2{printf "Used: %s MB  Free: %s MB  (%.2f%% Used)\n", $3, $4, $3*100/$2 }'

echo "Disk Usage:"
df -h / | awk 'NR==2{printf "Used: %s  Free: %s  (%.2f%% Used)\n", $3, $4, $3*100/($3+$4) }'

echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -6

echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -6

exit 0
