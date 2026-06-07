#!/bin/bash

# Rotina de monitoramento de recursos do servidor da Clínica Veterinária

monitorar_sistema() {
    # Coletar data e hora da execução
    DATA_COLETA=$(date +"%Y-%m-%d %H:%M:%S")
    
    echo "==================================================="
    echo "Painel de Monitoramento - Clínica Veterinária"
    echo "Data da coleta: $DATA_COLETA"
    echo "==================================================="

    # Coleta de métricas 
    # Pega o uso de CPU limitando à primeira casa decimal
    CPU_USO=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
    
    # Calcula a porcentagem de uso da Memória RAM
    MEM_USO=$(free | grep Mem | awk '{print int($3/$2 * 100)}')
    
    # Pega a porcentagem de uso da partição principal de disco (/)
    DISCO_USO=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

    echo "Status Atual dos Recursos:"
    echo "- Uso de CPU: ${CPU_USO}%"
    echo "- Uso de Memória RAM: ${MEM_USO}%"
    echo "- Uso de Disco: ${DISCO_USO}%"
    
    echo "---------------------------------------------------"
    echo "Análise de Alertas:"

    # Validação de Alertas de Hardware (Limiar de 80%)
    if [ "$CPU_USO" -ge 80 ]; then
        echo "[ALERTA] Uso de CPU muito alto no servidor!"
    else
        echo "[OK] CPU operando com folga."
    fi

    if [ "$MEM_USO" -ge 80 ]; then
        echo "[ALERTA] Uso de memória acima de 80%!"
    else
        echo "[OK] Memória RAM dentro do limite seguro."
    fi

    if [ "$DISCO_USO" -ge 80 ]; then
        echo "[ALERTA] Espaço em disco crítico para os prontuários!"
    else
        echo "[OK] Espaço em disco adequado."
    fi

    # Validação do status do Apache
    if service apache2 status | grep -q "is running"; then
        echo "[OK] Apache em execução. Portal da clínica ONLINE."
    else
        echo "[ALERTA] Apache NÃO está em execução! O portal está fora do ar."
    fi
    echo "==================================================="
}

monitorar_sistema