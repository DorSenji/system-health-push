# system-health-push

A simple Bash script to monitor your Linux system’s health and send daily status reports via **Pushover** notifications.

---

## Features

- Shows disk usage on root partition  
- Shows memory usage  
- Shows uptime  
- Checks if important services (like ssh, cron, networking) are running  
- Sends a clean, emoji-enhanced notification via Pushover

---

## Requirements

- Linux system with **bash** and **curl** installed  
- A free account on [Pushover](https://pushover.net) to get your **User Key** and **API Token**

---

## Setup Instructions

### 1. Clone or download the repo

- git clone https://github.com/yourusername/system-health-push.git
- cd system-health-push

  (Or download and unzip the ZIP from GitHub)

### 2. Edit the script to add your Pushover keys
Open system_health_check.sh in a text editor, and replace:

- PUSHOVER_USER="your_user_key_here"
- PUSHOVER_TOKEN="your_app_token_here"

with your actual keys from https://pushover.net.

### 3. Make the script executable

- chmod +x system_health_check.sh
  
### 4. Run the script manually to test

- ./system_health_check.sh

  --> You should receive a Pushover notification on your device with your system’s status.

### 5. (Optional) Automate with cron
To get daily notifications, add a cron job:

- crontab -e
--> Add this line to run the script every day at 7 AM:

- 0 7 * * * /full/path/to/system_health_check.sh
  
(Make sure to replace /full/path/to/ with the actual path of the script)

---

## Customize
### To monitor other services, edit the SERVICES array inside the script:

--> SERVICES=("ssh" "cron" "networking")

Add or remove service names as needed.

## Troubleshooting
### 1. Make sure your system has curl installed:

- which curl
  
Check your Pushover keys are correct and active.

### 2. Ensure script permissions:

- chmod +x system_health_check.sh
  
Test the script manually before relying on cron.

---

### Questions or Contributions?
### Feel free to open issues or submit pull requests!
