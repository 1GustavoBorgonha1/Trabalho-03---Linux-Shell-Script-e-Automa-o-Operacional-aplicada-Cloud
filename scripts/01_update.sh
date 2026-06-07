#!/bin/bash

# Função para atualizar os pacotes do servidor da clínica

atualizar_sistema() {
    echo "Iniciando a atualização do sistema base da Clínica Veterinária..."
    
    if apt update && apt upgrade -y > /app/logs/update_sistema.log 2>&1; then
        echo "[SUCESSO] Servidor da Clínica atualizado com sucesso!"
        echo "Log salvo em: /app/logs/update_sistema.log"
    else
        echo "[ERRO] Falha ao atualizar o sistema. Verifique o arquivo de log."
    fi
}

atualizar_sistema