#!/bin/bash

LOG_ONLINE="/nginx_status/online"
LOG_OFFLINE="/nginx_status/offline"
SERVICE_NAME="nginx"

STATUS=$(systemctl is-active $SERVICE_NAME)

DATE_TIME=$(date +'%Y-%m-%d_%H-%M-%S')

MESSAGE="Verifica o status do $SERVICE_NAME"

if [ "$STATUS" == "active" ]; then

  LOG_ONLINE="$LOG_ONLINE/nginx_status_online_$DATE_TIME.log"
  echo "$DATE_TIME - $MESSAGE - Status: ONLINE" > "$LOG_ONLINE"
else
  LOG_OFFLINE="$LOG_OFFLINE/nginx_status_offline_$DATE_TIME.log"
  echo "$DATE_TIME - $MESSAGE - Status: OFFLINE" > "$LOG_OFFLINE"
fi
