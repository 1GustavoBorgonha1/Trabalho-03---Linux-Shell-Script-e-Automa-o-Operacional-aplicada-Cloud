#!/bin/bash

# Rotina para gerar o relatório consolidado de operações da Clínica Veterinária

ARQUIVO_RELATORIO="/app/logs/relatorio_execucao.txt"
DATA_HORA=$(date +"%Y-%m-%d %H:%M:%S")

gerar_relatorio() {
    echo "Gerando relatório operacional da Clínica Veterinária..."

    # Inicia a criação do arquivo
    echo "===================================================" > "$ARQUIVO_RELATORIO"
    echo "        RELATÓRIO OPERACIONAL DA CLÍNICA           " >> "$ARQUIVO_RELATORIO"
    echo "===================================================" >> "$ARQUIVO_RELATORIO"
    echo "Data e Hora da Geração: $DATA_HORA" >> "$ARQUIVO_RELATORIO"
    echo "Projeto: Trabalho 03 - Cloud Computing" >> "$ARQUIVO_RELATORIO"
    echo "Aluno: Gustavo" >> "$ARQUIVO_RELATORIO"
    echo "Tema: Clínica Veterinária" >> "$ARQUIVO_RELATORIO"
    echo "---------------------------------------------------" >> "$ARQUIVO_RELATORIO"

    echo "1. STATUS DO SERVIDOR WEB (APACHE):" >> "$ARQUIVO_RELATORIO"
    if service apache2 status | grep -q "is running"; then
        echo "   [OK] Apache está em execução." >> "$ARQUIVO_RELATORIO"
    else
        echo "   [ERRO] Apache não está em execução." >> "$ARQUIVO_RELATORIO"
    fi
    echo "---------------------------------------------------" >> "$ARQUIVO_RELATORIO"

    echo "2. ESPAÇO EM DISCO GERAL:" >> "$ARQUIVO_RELATORIO"
    # df -h coleta o espaço, grep /$ filtra a partição principal
    df -h | grep -E "^Filesystem|/$" >> "$ARQUIVO_RELATORIO"
    echo "---------------------------------------------------" >> "$ARQUIVO_RELATORIO"

    echo "3. USO DOS DIRETÓRIOS DA CLÍNICA:" >> "$ARQUIVO_RELATORIO"
    # du -sh mede o tamanho das pastas específicas
    du -sh /app/clinica_vet/* 2>/dev/null >> "$ARQUIVO_RELATORIO"
    echo "---------------------------------------------------" >> "$ARQUIVO_RELATORIO"

    echo "4. ÚLTIMOS BACKUPS GERADOS:" >> "$ARQUIVO_RELATORIO"
    ls -lh /app/backups/ 2>/dev/null >> "$ARQUIVO_RELATORIO"
    echo "---------------------------------------------------" >> "$ARQUIVO_RELATORIO"

    echo "5. ÚLTIMOS LOGS DO SISTEMA:" >> "$ARQUIVO_RELATORIO"
    ls -lh /app/logs/ 2>/dev/null >> "$ARQUIVO_RELATORIO"
    echo "---------------------------------------------------" >> "$ARQUIVO_RELATORIO"

    echo "6. ARQUIVOS PUBLICADOS (PORTAL WEB):" >> "$ARQUIVO_RELATORIO"
    ls -lh /var/www/html/ 2>/dev/null >> "$ARQUIVO_RELATORIO"
    echo "---------------------------------------------------" >> "$ARQUIVO_RELATORIO"

    echo "7. USUÁRIOS E PERMISSÕES PRINCIPAIS:" >> "$ARQUIVO_RELATORIO"
    echo "   - Auditoria do diretório de Prontuários:" >> "$ARQUIVO_RELATORIO"
    ls -ld /app/clinica_vet/prontuarios 2>/dev/null >> "$ARQUIVO_RELATORIO"
    echo "   - Auditoria do diretório de Exames:" >> "$ARQUIVO_RELATORIO"
    ls -ld /app/clinica_vet/exames 2>/dev/null >> "$ARQUIVO_RELATORIO"
    echo "   - Informações do usuário vet_admin:" >> "$ARQUIVO_RELATORIO"
    id vet_admin 2>/dev/null >> "$ARQUIVO_RELATORIO"
    echo "===================================================" >> "$ARQUIVO_RELATORIO"

    echo "[SUCESSO] Relatório salvo com sucesso em: $ARQUIVO_RELATORIO"
    
    echo "Exibindo o conteúdo gerado no terminal para conferência:"
    echo "---------------------------------------------------"
    cat "$ARQUIVO_RELATORIO"
}

gerar_relatorio