#!/bin/bash

# Defina o diretório de destino para os arquivos de log
LOG_ONLINE="/nginx_status/online"
LOG_OFFLINE="/nginx_status/offline"
SERVICE_NAME="nginx"

# Verifica o status do serviço Nginx
STATUS=$(systemctl is-active $SERVICE_NAME)

# Define a data e hora atual para o nome do arquivo
DATE_TIME=$(date +'%Y-%m-%d_%H-%M-%S')

# Cria a mensagem personalizada
MESSAGE="Verificação do status do serviço $SERVICE_NAME"

# Verifica o status do serviço e gera o arquivo correspondente
if [ "$STATUS" == "active" ]; then
  # Arquivo para status ONLINE
  LOG_ONLINE="$LOG_ONLINE/nginx_status_online_$DATE_TIME.log"
  echo "$DATE_TIME - $MESSAGE - Status: ONLINE" > "$LOG_ONLINE"
else
  # Arquivo para status OFFLINE
  LOG_OFFLINE="$LOG_OFFLINE/nginx_status_offline_$DATE_TIME.log"
  echo "$DATE_TIME - $MESSAGE - Status: OFFLINE" > "$LOG_OFFLINE"
fi
