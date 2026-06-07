#!/bin/bash

# Prepara o servidor web para o sistema da Clínica Veterinária

LOG_FILE="/app/logs/apache_install.log"

instalar_apache() {
    echo "Iniciando instalação do Apache e ImageMagick (para exames e fotos dos pets)..."
    
    # Instala os pacotes e joga a saída para o arquivo de log
    if apt install -y apache2 imagemagick > "$LOG_FILE" 2>&1; then
        echo "[SUCESSO] Apache e ImageMagick instalados com sucesso!"
        
        # Inicia o serviço
        service apache2 start >> "$LOG_FILE" 2>&1
        echo "[SUCESSO] Servidor web da Clínica iniciado."
    else
        echo "[ERRO] Falha na instalação. Verifique o log em $LOG_FILE."
    fi
}

verificar_apache() {
    echo "---------------------------------------------------"
    echo "Verificando o status do servidor..."
    # Checa se o serviço do apache está ativo
    if service apache2 status | grep -q "is running"; then
        echo "[OK] O servidor da Clínica Veterinária está ONLINE!"
    else
        echo "[ALERTA] O servidor não está rodando."
    fi
}

versao_apache() {
    echo "---------------------------------------------------"
    echo "Versões instaladas no ambiente da Clínica:"
    # O comando 'head -n 1' pega apenas a primeira linha da saída para ficar mais limpo
    apache2 -v | head -n 1
    echo "ImageMagick pronto para processamento de imagens veterinárias."
    echo "---------------------------------------------------"
}

# Chamando as funções na ordem exigida
instalar_apache
verificar_apache
versao_apache