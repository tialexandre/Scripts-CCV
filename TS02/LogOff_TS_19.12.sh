#!/bin/bash

# Configurações fixas
SERVER="10.1.19.11"
APP_ALIAS="LogOff_TS"
DOMAIN="intranet"

# --- Função para verificar e instalar o xfreerdp ---
verificar_xfreerdp() {
    if ! command -v xfreerdp &> /dev/null; then
        echo "[INFO] xfreerdp não encontrado. Instalando..."

        if [ -f /etc/debian_version ]; then
            sudo apt update && sudo apt install -y freerdp2-x11
        elif [ -f /etc/redhat-release ]; then
            sudo dnf install -y freerdp
        elif [ -f /etc/arch-release ]; then
            sudo pacman -Sy --noconfirm freerdp
        else
            echo "[ERRO] Distribuição Linux não suportada para instalação automática."
            exit 1
        fi

        # Verifica se a instalação foi bem-sucedida
        if ! command -v xfreerdp &> /dev/null; then
            echo "[ERRO] Falha ao instalar o xfreerdp. Saindo."
            exit 1
        fi
    fi
}

# --- Executa verificação ---
verificar_xfreerdp

# --- Verifica se existe o arquivo .login ---
SCRIPT_DIR="$(dirname "$0")"
LOGIN_FILE="$SCRIPT_DIR/.login"

if [ -f "$LOGIN_FILE" ]; then
    USERNAME=$(sed -n '1p' "$LOGIN_FILE")
    PASS=$(sed -n '2p' "$LOGIN_FILE")
    echo "[INFO] Credenciais carregadas automaticamente do arquivo .login"
else
    read -p "Usuário: " USERNAME
    read -s -p "Senha: " PASS
    echo
fi

# Monta o usuário completo
USER_FULL="$DOMAIN\\$USERNAME"

# Executa conexão RDP com RemoteApp
xfreerdp /v:$SERVER \
         /u:"$USER_FULL" \
         /p:"$PASS" \
         /app:"||$APP_ALIAS" \
         /sec:rdp \
         /cert:ignore \
         /clipboard & disown

