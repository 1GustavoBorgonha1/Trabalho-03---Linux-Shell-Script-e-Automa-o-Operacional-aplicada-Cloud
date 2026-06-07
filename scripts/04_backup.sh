#!/bin/bash

# Rotina para realizar o backup dos prontuários e dados da Clínica Veterinária

# Variáveis para diretório de origem e destino
DIR_ORIGEM="/app/clinica_vet"
DIR_DESTINO="/app/backups"
ARQUIVO_LOG="/app/logs/backup_execucao.log"

realizar_backup() {
    echo "Iniciando processo de backup da Clínica Veterinária..."

    # Formatar data e hora atual
    DATA_HORA=$(date +"%Y-%m-%d_%H-%M")
    
    # Montar o nome do arquivo com a data/hora
    NOME_ARQUIVO="backup_clinica_vet_${DATA_HORA}.tar.gz"
    CAMINHO_COMPLETO="${DIR_DESTINO}/${NOME_ARQUIVO}"

    echo "Compactando arquivos de pacientes, exames e prontuários..."
    
    # Gerar o arquivo .tar.gz e registrar saída no log
    if tar -czf "${CAMINHO_COMPLETO}" "${DIR_ORIGEM}" >> "${ARQUIVO_LOG}" 2>&1; then
        
        # Validar se o arquivo realmente foi criado no diretório de destino
        if [ -f "${CAMINHO_COMPLETO}" ]; then
            echo "[SUCESSO] Backup gerado e validado com segurança!"
            echo "Arquivo salvo: ${NOME_ARQUIVO}"
            echo "Destino: ${DIR_DESTINO}"
            
            # Registrar sucesso no log
            echo "[${DATA_HORA}] Backup ${NOME_ARQUIVO} concluído com sucesso." >> "${ARQUIVO_LOG}"
        else
            echo "[ERRO] Falha na validação: O arquivo não foi encontrado no destino."
            echo "[${DATA_HORA}] Erro: Arquivo de backup não gerado." >> "${ARQUIVO_LOG}"
        fi
    else
        echo "[ERRO] Falha ao executar a compactação. Verifique o log em ${ARQUIVO_LOG}."
    fi
}

realizar_backup