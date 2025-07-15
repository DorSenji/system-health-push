#!/bin/bash


# System Health Check Script
# Checks disk usage, memory load, uptime, and important services, then sends a Pushover notification.


echo "Script is running.."


# Services to check (customize as needed)
SERVICES=("ssh" "cron" "networking")


# Function to check if services are running
check_services() {
  local output=""
  for service in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$service"; then
      output+="$service: running\n"
    else
      output+="$service: NOT running\n"
    fi
  done
  echo -e "$output"
}


# === Gather System Info ===


# Disk usage
DISK_CLEAN=$(df -h / | awk 'NR==2 {print $5 " used (" $3 "/" $2 ")"}')


# Memory usage
MEM_CLEAN=$(free -m | awk '/Mem:/ {printf "%.0f%% used (%d/%d MB)", $3/$2*100, $3, $2}')


# Uptime
UPTIME=$(uptime -p | cut -d " " -f2-)


# Service status
SERVICES_STATUS=""
for service in "${SERVICES[@]}"; do
  if systemctl is-active --quiet "$service"; then
    SERVICES_STATUS+="✅ $service\n"
  else
    SERVICES_STATUS+="❌ $service\n"
  fi
done


# === Pushover Config ===
PUSHOVER_USER="Insert your User Token"
PUSHOVER_TOKEN="Insert your API Key"


# Build final message
TITLE="🧠 System Report: $(hostname)"
MESSAGE="📊 Disk: $DISK_CLEAN\n🧠 RAM: $MEM_CLEAN\n📈 Uptime: $UPTIME\n🔧 Services:\n$SERVICES_STATUS"


# Send notification via Pushover
curl -s \
  -F "token=$PUSHOVER_TOKEN" \
  -F "user=$PUSHOVER_USER" \
  -F "title=$TITLE" \
  -F "message=$MESSAGE" \
  -F "priority=0" \
  -F "sound=pushover" \
  https://api.pushover.net/1/messages.json


