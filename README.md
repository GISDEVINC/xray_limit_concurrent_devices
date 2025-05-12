# xray_limit_concurrent_devices

限制Xray同时在线设备总数。注意：假设每个设备有不同的IP地址。

## 📝 概述

Xray未能提供限制同时在线设备数的功能，是诸多用户的痛点之一。本仓库为该功能提供一种可能的实现方式。

## 🚀 特性

- 自定义Xray日志路径和文本文件路径。
- 自定义同时在线设备的总数。
- 自定义Xray监听的端口。
- 为不同Client定制限制。

## 🛠️ 安装/设置

```bash
# 安装依赖
apt install inotify-tools dsniff screen

# 下载并修改脚本文件权限
curl -O https://raw.githubusercontent.com/GISDEVINC/xray_limit_concurrent_devices/main/xray_limit_concurrent_devices.sh
chmod -R 755 xray_limit_concurrent_devices.sh

# 创建一个新的会话
screen -S monitor_devices

# 启动脚本。请查看下面具体的参数说明。
bash xray_limit_concurrent_devices.sh

# 分离会话
按 Ctrl+A+D

## ⚙️ 参数配置
- Xray日志文件路径: 在Xray的config.json文件中log字段的access部分指定的值。例如：/var/access.log。
- IP记录文本路径: 文本具体路径，脚本会根据路径自动新建文本。例如：/var/ip_list.txt。
- 限制设备数量: 最大同时在线设备数量。例如：3。
- 代理服务所在端口: 代理监听的端口。例如：12345。
- 用户组标识符: 唯一标识符，用于判定Client。如果留空，表示整个Xray仅允许特定数量的IP同时连接，无论inbound和client。
