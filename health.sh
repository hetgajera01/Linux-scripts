#!/bin/bash

disk_thresold=85
mem_thresold=90
cpu_thresold=80

disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$disk_usage" -gt "$disk_thresold" ]
then 
    echo "[Alert]: Low disk space"
fi

mem_usage=$(free | awk '/Mem:/ {print int($3/$2*100)}')
if [ "$mem_usage" -gt "$mem_thresold" ]
then
    echo "[Alert]: Low Memory space"
fi

cpu_usage=$(top -bn1 | grep "%Cpu(s)" | awk '{print int(100-$8)}')
if [ "$cpu_usage" -gt "$cpu_thresold" ]
then
    echo "[Alert]: High cpu utilization"
fi