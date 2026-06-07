#!/bin/bash

# Função para estruturar os diretórios do sistema da Clínica Veterinária

criar_estrutura_clinica() {
    echo "Iniciando a preparação dos diretórios da Clínica Veterinária..."

    # Define o caminho base como uma variável
    BASE_DIR="/app/clinica_vet"

    # Valida se o diretório já existe e remove a estrutura antiga com segurança
    if [ -d "$BASE_DIR" ]; then
        echo "Limpando diretórios e registros antigos da clínica em $BASE_DIR..."
        rm -rf "$BASE_DIR"
    fi

    # Cria os diretórios relacionados ao tema e as subpastas operacionais
    echo "Criando pastas para prontuários, exames, pacientes, logs, dados e publicação..."
    mkdir -p "$BASE_DIR/prontuarios"
    mkdir -p "$BASE_DIR/exames"
    mkdir -p "$BASE_DIR/pacientes"
    mkdir -p "$BASE_DIR/logs"
    mkdir -p "$BASE_DIR/dados"
    mkdir -p "$BASE_DIR/publicacao"

    # Cria arquivos iniciais obrigatórios
    echo "Gerando arquivos de registro iniciais..."
    touch "$BASE_DIR/logs/sistema.log"
    touch "$BASE_DIR/dados/registro_geral.txt"
    
    # Insere um conteúdo inicial no arquivo de log
    echo "Sistema da Clínica Veterinária iniciado." > "$BASE_DIR/logs/sistema.log"

    echo "[SUCESSO] Estrutura montada com sucesso!"
    echo "---------------------------------------------------"
    echo "Visualizando a árvore de diretórios criada:"
    ls -R "$BASE_DIR"
    echo "---------------------------------------------------"
}

criar_estrutura_clinica