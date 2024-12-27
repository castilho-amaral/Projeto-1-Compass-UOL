# Instalação do WSL, Criação de uma Instância EC2 e Instalação do NGINX

Este repositório contém um guia passo a passo para:
1. Instalar o WSL (Windows Subsystem for Linux) no Windows.
2. Criar uma instância EC2 na AWS.
3. Instalar o NGINX na instância EC2.

## Índice

1. [Instalação do WSL no Windows](#1-instalação-do-wsl-no-windows)
2. [Criação de uma Instância EC2 na AWS](#2-criação-de-uma-instância-ec2-na-aws)
3. [Instalação do NGINX na Instância EC2](#3-instalação-do-nginx-na-instância-ec2)
4. [Conclusão](#4-conclusão)

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
    ssh -i "caminho/para/sua/chave.pem" ec2-user@ip-da-instancia
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

## 4. Conclusão

Com esses passos, você conseguiu:
- Instalar o **WSL** no seu Windows e configurar um ambiente Linux.
- Criar uma **instância EC2** na AWS com **Ubuntu**.
- Instalar e configurar o **NGINX** na instância EC2.

Agora, seu servidor NGINX está pronto e em funcionamento na instância EC2.

---

## Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
