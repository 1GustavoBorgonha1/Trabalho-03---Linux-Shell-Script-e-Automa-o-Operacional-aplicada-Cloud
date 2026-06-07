#!/bin/bash

# Script de gerenciamento de processos do servidor da Clínica Veterinária

listar_processos() {
    echo "---------------------------------------------------"
    echo "Listando processos ativos no servidor da clínica..."
    echo "---------------------------------------------------"
    # Exibe os processos, limitando a 20 linhas.
    ps aux | head -n 20
    echo "---------------------------------------------------"
}

buscar_processo() {
    # Verifica se o parâmetro do nome foi informado
    if [ -z "$1" ]; then
        echo "[ERRO] Você precisa informar o nome do processo."
        echo "Exemplo: ./06_processos.sh buscar apache2"
        return 1
    fi
    
    echo "Buscando serviços da clínica com o nome: $1..."
    echo "---------------------------------------------------"
    # Busca o processo ignorando letras maiúsculas/minúsculas e remove o próprio grep da lista
    ps aux | grep -i "$1" | grep -v "grep"
    echo "---------------------------------------------------"
}

matar_processo() {
    # REGRA DE SEGURANÇA: Impede encerramento sem PID informado
    if [ -z "$1" ]; then
        echo "[BLOQUEADO] Ação de segurança do servidor acionada!"
        echo "Motivo: Nenhum PID foi informado para encerramento."
        echo "Uso correto: ./06_processos.sh matar <PID>"
        return 1
    fi
    
    echo "[ALERTA] Tentando encerrar o processo com PID: $1..."
    
    # Tenta matar o processo forçadamente (-9)
    if kill -9 "$1" 2>/dev/null; then
        echo "[SUCESSO] Processo $1 encerrado com segurança."
    else
        echo "[ERRO] Falha ao encerrar. Verifique se o PID $1 realmente existe."
    fi
}

# Captura os parâmetros passados no terminal
ACAO=$1
PARAMETRO=$2

# Menu invisível que direciona para a função correta baseada no parâmetro
case "$ACAO" in
    listar)
        listar_processos
        ;;
    buscar)
        buscar_processo "$PARAMETRO"
        ;;
    matar)
        matar_processo "$PARAMETRO"
        ;;
    *)
        # Se digitar errado ou não passar parâmetro, exibe as instruções de uso
        echo "Uso incorreto. Comandos de administração da Clínica Veterinária:"
        echo "  $0 listar"
        echo "  $0 buscar <nome_do_processo>"
        echo "  $0 matar <numero_do_PID>"
        ;;
esac