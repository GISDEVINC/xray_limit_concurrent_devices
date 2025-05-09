LOG_FILE="access.log"
IP_FILE="ip_list.txt"
# 确保IP记录文件存在
mkdir -p "$(dirname "$IP_FILE")"
touch "$IP_FILE"
echo -e "请输入限制设备数量."
read MAX_IP
echo -e "请输入代理服务所在端口."
read p_port
echo -e "请输入用户组标识符."
read user_tag

# 开始监控
inotifywait -m -e modify "$LOG_FILE" --format "%w%f" | while read file
do
    # 读取符合条件的最新IP
    NEW_IP=$(tail -n 50 "$LOG_FILE" | grep "$user_tag" | grep "accepted" | awk -F 'from ' '{print $2}' | awk '{print $1}' | awk -F ':' '{print $1}' | head -n 1)
    # IP为空则跳过
    if [[ -z "$NEW_IP" ]]; then
        continue
    fi

    # 查看IP是否已存在
    if grep -Fxq "$NEW_IP" "$IP_FILE"; then
        continue
    fi

    # 获取当前IP总数
    IP_COUNT=$(wc -l < "$IP_FILE")

    if [[ $IP_COUNT -lt $MAX_IP ]]; then
        echo "$NEW_IP" >> "$IP_FILE"
    else
        OLD_IP=$(head -n 1 "$IP_FILE")
        timeout 30s tcpkill -9 host "$OLD_IP" and port $p_port 2>/dev/null &
        echo "断流${OLD_IP}"
        # 替换最旧的IP（第一行）
        tail -n +2 "$IP_FILE" > "$IP_FILE.tmp"
        echo "$NEW_IP" >> "$IP_FILE.tmp"
        mv "$IP_FILE.tmp" "$IP_FILE"
    fi
done
