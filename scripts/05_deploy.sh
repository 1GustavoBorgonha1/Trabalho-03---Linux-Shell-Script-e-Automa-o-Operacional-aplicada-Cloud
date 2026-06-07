#!/bin/bash

# Script para publicar o portal da Clínica Veterinária no servidor web

DIR_ORIGEM="/app/source"
DIR_DESTINO="/var/www/html"
ARQUIVO_LOG="/app/logs/deploy_portal.log"

realizar_deploy() {
    echo "Iniciando o deploy do portal da Clínica Veterinária..."
    
    # Registra o início do deploy no log
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] Iniciando deploy do portal..." >> "$ARQUIVO_LOG"

    # Limpar o diretório de destino antes do deploy
    echo "Limpando versão anterior do portal web..."
    rm -rf "$DIR_DESTINO"/* >> "$ARQUIVO_LOG" 2>&1

    # Copiar os arquivos da pasta source para o diretório do Apache
    echo "Copiando novos arquivos para o servidor..."
    if cp -r "$DIR_ORIGEM"/* "$DIR_DESTINO/" >> "$ARQUIVO_LOG" 2>&1; then
        echo "[SUCESSO] Arquivos copiados com sucesso!"
    else
        echo "[ERRO] Falha ao copiar os arquivos. Verifique o diretório source/."
        return 1
    fi

    echo "---------------------------------------------------"
    echo "Arquivos publicados no diretório $DIR_DESTINO:"
    ls -la "$DIR_DESTINO"
    echo "---------------------------------------------------"

    # Validar se o index.html existe no destino
    if [ -f "$DIR_DESTINO/index.html" ]; then
        echo "[OK] Validação confirmada: index.html encontrado no servidor!"
        echo "[$(date +"%Y-%m-%d %H:%M:%S")] Deploy concluído com sucesso. index.html validado." >> "$ARQUIVO_LOG"
        echo "O portal da Clínica Veterinária está pronto para acesso."
    else
        echo "[ERRO] Validação falhou: index.html NÃO encontrado no destino!"
        echo "[$(date +"%Y-%m-%d %H:%M:%S")] Erro no deploy: index.html ausente." >> "$ARQUIVO_LOG"
    fi
}

realizar_deploy