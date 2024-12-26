# Instalação do WSL, criação de uma instância EC2 e monitoramento do NGINX

Este repositório contém um guia passo a passo para:
1. Instalar o WSL (Windows Subsystem for Linux) no Windows.
2. Criar uma instância EC2 na AWS.
3. Instalar o NGINX na instância EC2.
4. Criar um script para verificar se o NGINX está **online** ou **offline**.
5. Configurar o script para rodar automaticamente a cada 5 minutos.

## Índice

1. [Instalação do WSL no Windows](#1-instalação-do-wsl-no-windows)
2. [Criação de uma Instância EC2 na AWS](#2-criação-de-uma-instância-ec2-na-aws)
3. [Instalação do NGINX na Instância EC2](#3-instalação-do-nginx-na-instância-ec2)
4. [Criação do Script de Verificação de Status do NGINX](#4-criação-do-script-de-verificação-de-status-do-nginx)
5. [Configuração do Cron para Rodar o Script a Cada 5 Minutos](#5-configuração-do-cron-para-rodar-o-script-a-cada-5-minutos)
6. [Verificação dos Logs do Script](#6-verificação-dos-logs-do-script)
7. [Conclusão](#7-conclusão)

---

## 1. Instalação do WSL no Windows

O **Windows Subsystem for Linux (WSL)** permite rodar um sistema Linux completo no Windows. Para instalar o WSL, siga as etapas abaixo:

1. **Habilitar o WSL**:
    - Abra o PowerShell como **Administrador** e execute o comando:
    ```bash
    wsl --install
    ```

2. **Escolher uma Distribuição Linux**:
    - Após reiniciar o sistema, abra a **Microsoft Store** e escolha uma distribuição Linux, como **Ubuntu 20.04 LTS**.

3. **Configuração inicial do WSL**:
    - Após a instalação, abra a distribuição Linux (Ubuntu, por exemplo), configure o nome de usuário e senha para o ambiente Linux.

4. **Atualizar o sistema WSL**:
    - No terminal do Ubuntu (ou outra distribuição escolhida), execute os seguintes comandos:
    ```bash
    sudo apt update
    sudo apt upgrade
    ```

---

## 2. Criação de uma Instância EC2 na AWS

Para criar uma instância EC2 na AWS, siga os passos abaixo:

1. **Acesse o Console da AWS**:
    - Vá para o [Console da AWS](https://aws.amazon.com/console/).

2. **Criar uma Instância EC2**:
    - No Console da AWS, vá para **EC2** > **Launch Instance**.
    - Escolha uma **Amazon Machine Image (AMI)**, como **Ubuntu 20.04 LTS**.
    - Escolha o tipo de instância, por exemplo, **t2.micro** (instância gratuita).
    - Em **Key Pair**, crie ou selecione um par de chaves para acessar a instância.
    - Em **Security Group**, permita tráfego na porta **22** para SSH e **80** para HTTP.

3. **Conectar à Instância via SSH**:
    - Após a instância ser criada, obtenha o **IP público** da instância.
    - No terminal (WSL ou outro terminal), execute o comando SSH para acessar a instância EC2:
    ```bash
    ssh -i "caminho/para/sua/chave.pem" ubuntu@ip-da-instancia
    ```

---

## 3. Instalação do NGINX na Instância EC2

Agora, vamos instalar o **NGINX** na nossa instância EC2.

1. **Conectar à Instância EC2**:
    - Se ainda não fez isso, acesse sua instância EC2 conforme descrito no passo anterior.

2. **Instalar o NGINX**:
    - Atualize o repositório de pacotes e instale o NGINX com os comandos:
    ```bash
    sudo apt update
    sudo apt install nginx -y
    ```

3. **Iniciar o Serviço NGINX**:
    - Após a instalação, inicie o serviço NGINX:
    ```bash
    sudo systemctl start nginx
    ```

4. **Verificar se o NGINX está funcionando**:
    - Abra seu navegador e digite o **IP público** da instância EC2. Você verá a página padrão de boas-vindas do NGINX.

---

## 4. Criação do Script de Verificação de Status do NGINX

Agora vamos criar um script que verifica se o NGINX está **online** ou **offline**.

1. **Criar o Script de Verificação**:
    - Na instância EC2, crie um arquivo de script chamado `verificar_nginx.sh`:
    ```bash
    nano verificar_nginx.sh
    ```

    - Adicione o seguinte código ao script:
    ```bash
    #!/bin/bash
    # Verificar se o serviço NGINX está rodando
    if systemctl is-active --quiet nginx
    then
        echo "NGINX está ONLINE" >> /var/log/nginx_status.log
    else
        echo "NGINX está OFFLINE" >> /var/log/nginx_status.log
    fi
    ```

    - Salve e feche o arquivo (Ctrl + X, depois Y e Enter).

2. **Tornar o Script Executável**:
    - Torne o script executável com o comando:
    ```bash
    chmod +x verificar_nginx.sh
    ```

---

## 5. Configuração do Cron para Rodar o Script a Cada 5 Minutos

Para rodar o script a cada 5 minutos, usaremos o **cron**.

1. **Editar o Cron**:
    - Execute o seguinte comando para editar o arquivo cron:
    ```bash
    crontab -e
    ```

2. **Adicionar a Tarefa no Cron**:
    - Adicione a seguinte linha no final do arquivo de configuração do cron para rodar o script a cada 5 minutos:
    ```bash
    */5 * * * * /bin/bash /caminho/para/verificar_nginx.sh
    ```

    - Certifique-se de substituir `/caminho/para/verificar_nginx.sh` pelo caminho correto do script.

3. **Salvar e Sair**:
    - Salve e saia do editor (Ctrl + X, depois Y e Enter).

Agora, o cron vai executar o script automaticamente a cada 5 minutos.

---

## 6. Verificação dos Logs do Script

O script cria um arquivo de log em `/var/log/nginx_status.log` onde você pode verificar se o NGINX está **online** ou **offline**.

Para visualizar os logs, execute o seguinte comando na instância EC2:

```bash
cat /var/log/nginx_status.log
