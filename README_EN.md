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
chmod -R 755 xray_limit_concurrent_devices.sh

# Create a new session
screen -S monitor_devices

# Start the script. Please see below the specific parameter configuration. 
bash xray_limit_concurrent_devices.sh

# detach the session
Press Ctrl+A+D

## ⚙️ Parameter configuration
- Xray日志文件路径: The value specified in the 'access' field of the 'log' in config.json of Xray, e.g., /var/access.log.
- IP记录文本路径: The specific path of the text file used to record recent successfully-established IP addresses. For example, /var/ip_list.txt.
- 限制设备数量: The total count of concurrently online devices you wish. For example, 3.
- 代理服务所在端口: The port Xray listening to. For example, 12345.
- 用户组标识符: A unique identifier used to match the client. Leaving it empty means Xray allows only a total of specific count of IPs to connect simultaneously, regardless of inbounds and clients. 
