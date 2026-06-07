#!/bin/bash

# Menu principal interativo para administração da infraestrutura da Clínica Veterinária

# Função para desenhar a interface do menu na tela
exibir_menu() {
    clear 
    echo "==================================================="
    echo "Criado por: Gustavo"
    echo "Instituição: Unidavi"
    echo "Tema: Clínica Veterinária"
    echo "==================================================="
    echo "               MENU DEVOPS CLOUD                   "
    echo "==================================================="
    echo "1 - Atualizar sistema"
    echo "2 - Instalar Apache"
    echo "3 - Criar estrutura do projeto"
    echo "4 - Realizar backup"
    echo "5 - Fazer deploy"
    echo "6 - Ver processos"
    echo "7 - Monitorar sistema"
    echo "8 - Configurar usuários e permissões"
    echo "9 - Gerar relatório"
    echo "0 - Sair"
    echo "==================================================="
}

# Loop infinito para manter o menu rodando até o usuário escolher sair (0)
while true; do
    exibir_menu
    # Aguarda a entrada do usuário
    read -p "Escolha uma opção: " opcao
    echo ""

    # Direciona para o script correspondente baseado na escolha
    case $opcao in
        1) ./01_update.sh ;;
        2) ./02_apache.sh ;;
        3) ./03_estrutura.sh ;;
        4) ./04_backup.sh ;;
        5) ./05_deploy.sh ;;
        6) 
           # Como o requisito do menu é "Ver processos", chamamos com o parâmetro 'listar'
           ./06_processos.sh listar 
           ;;
        7) ./07_monitoramento.sh ;;
        8) ./08_usuarios_permissoes.sh ;;
        9) ./09_relatorio.sh ;;
        0) 
           echo "Encerrando o painel de administração da Clínica Veterinária. Até logo!"
           break 
           ;;
        *) 
           echo "[ERRO] Opção inválida. Escolha um número de 0 a 9." 
           ;;
    esac
    
    echo ""
    # Pausa a tela para que você possa ler o resultado do script antes do menu limpar a tela novamente
    read -p "Pressione [Enter] para voltar ao menu..."
done