# xray_limit_concurrent_devices

Limit total concurrently online devices for Xray. Noted: each device is assumed to have a unique IP address. 

## 📝 Overview

Xray failed to limit concurrently online devices, causing frustration for many users. This repo provides a reference implementation for this feature. 

## 🚀 Features

- Custom Xray log path and text file path. 
- Custom the total count of the concurrently online devices. 
- Custom the port Xray listening to.
- Custom limitations for different clients. 

## 🛠️ Installation / Setup

```bash
# Install dependencies
apt install inotify-tools dsniff screen

# Download and modify the permission for the shell file. 
curl -O https://raw.githubusercontent.com/GISDEVINC/xray_limit_concurrent_devices/main/xray_limit_concurrent_devices.sh
chmod -R 775 xray_limit_concurrent_devices.sh

# Create a new session
screen -S monitor_devices

# Start the script
bash xray_limit_concurrent_devices.sh

# detach the session
Press Ctrl+A+D
