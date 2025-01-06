#!/bin/bash

LOG_ONLINE="/nginx_status/online/"
LOG_OFFLINE="/nginx_status/offline/"
SERVICE_NAME="nginx"

STATUS=$(systemctl is-active $SERVICE_NAME)

DATE_TIME=$(date +'%H-%M_%d-%m-%Y')
MESSAGE="Verificação do status do serviço $SERVICE_NAME"

if [ "$STATUS" == "active" ]; then

  json=$(cat <<EOF
    {
       "timestamp": "$DATE_TIME",
       "message": "$MESSAGE",
       "status":  "$STATUS"
    }
EOF
)
  LOG_ONLINE="$LOG_ONLINE/nginx_status.json"
  echo "$json" >> "$LOG_ONLINE"
else

  json=$(cat <<EOF
    {
       "timestamp": "$DATE_TIME",
       "message": "$MESSAGE",
       "status":  "$STATUS"
    }
EOF
)
  LOG_OFFLINE="$LOG_OFFLINE/nginx_status.json"
  echo "$json" >> "$LOG_OFFLINE"
fi