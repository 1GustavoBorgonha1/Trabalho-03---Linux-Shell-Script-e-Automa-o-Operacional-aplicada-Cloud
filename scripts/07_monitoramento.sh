#!/bin/bash

# Rotina de monitoramento de recursos do servidor da Clínica Veterinária

monitorar_sistema() {

    #Local onde fica armazenados os arquivos de log
    LOG_FILE="/app/logs/monitoramento.log"
    mkdir -p "$(dirname "$LOG_FILE")"

    # Coletar data e hora da execução
    DATA_COLETA=$(date +"%Y-%m-%d %H:%M:%S")
    
    echo "==================================================="  | tee -a "$LOG_FILE"
    echo "Painel de Monitoramento - Clínica Veterinária" | tee -a "$LOG_FILE"
    echo "Data da coleta: $DATA_COLETA" | tee -a "$LOG_FILE"
    echo "===================================================" | tee -a "$LOG_FILE"

    # Coleta de métricas 
    # Pega o uso de CPU limitando à primeira casa decimal
    CPU_USO=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
    
    # Calcula a porcentagem de uso da Memória RAM
    MEM_USO=$(free | grep Mem | awk '{print int($3/$2 * 100)}')
    
    # Pega a porcentagem de uso da partição principal de disco (/)
    DISCO_USO=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

    echo "Status Atual dos Recursos:"  | tee -a "$LOG_FILE"
    echo "- Uso de CPU: ${CPU_USO}%"  | tee -a "$LOG_FILE"
    echo "- Uso de Memória RAM: ${MEM_USO}%"  | tee -a "$LOG_FILE"
    echo "- Uso de Disco: ${DISCO_USO}%"  | tee -a "$LOG_FILE"
    
    echo "---------------------------------------------------" | tee -a "$LOG_FILE"
    echo "Análise de Alertas:" | tee -a "$LOG_FILE"

    # Validação de Alertas de Hardware (Limiar de 80%)
    if [ "$CPU_USO" -ge 80 ]; then
        echo "[ALERTA] Uso de CPU muito alto no servidor!"  | tee -a "$LOG_FILE"
    else
        echo "[OK] CPU operando com folga." | tee -a "$LOG_FILE"
    fi

    if [ "$MEM_USO" -ge 80 ]; then
        echo "[ALERTA] Uso de memória acima de 80%!" | tee -a "$LOG_FILE"
    else
        echo "[OK] Memória RAM dentro do limite seguro." | tee -a "$LOG_FILE"
    fi

    if [ "$DISCO_USO" -ge 80 ]; then
        echo "[ALERTA] Espaço em disco crítico para os prontuários!" | tee -a "$LOG_FILE"
    else
        echo "[OK] Espaço em disco adequado." | tee -a "$LOG_FILE"
    fi

    # Validação do status do Apache
    if service apache2 status | grep -q "is running"; then
        echo "[OK] Apache em execução. Portal da clínica ONLINE." | tee -a "$LOG_FILE"
    else
        echo "[ALERTA] Apache NÃO está em execução! O portal está fora do ar." | tee -a "$LOG_FILE"
    fi
    echo "===================================================" | tee -a "$LOG_FILE"
}

monitorar_sistema