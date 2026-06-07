#!/bin/bash

# Comentário: Configuração de segurança, usuários e permissões da Clínica Veterinária

configurar_seguranca() {
    echo "Iniciando configuração de segurança do sistema da Clínica..."

    GRUPO="equipe_veterinaria"
    USUARIO="vet_admin"
    DIR_PRONTUARIOS="/app/clinica_vet/prontuarios"
    DIR_EXAMES="/app/clinica_vet/exames"

    # Criar grupo (o 2>/dev/null oculta o erro caso o grupo já tenha sido criado antes)
    echo "Criando o grupo de acesso: $GRUPO"
    groupadd "$GRUPO" 2>/dev/null || echo "[OK] O grupo $GRUPO já existe."

    # Criar usuário vinculando-o ao grupo
    echo "Criando o usuário administrativo: $USUARIO"
    useradd -m -g "$GRUPO" -s /bin/bash "$USUARIO" 2>/dev/null || echo "[OK] O usuário $USUARIO já existe."

    # Validar se a estrutura foi criada antes de tentar mudar permissões
    if [ ! -d "$DIR_PRONTUARIOS" ]; then
         echo "[ERRO] Diretórios da clínica não encontrados. Execute o script 03 de estrutura primeiro."
         return 1
    fi

    echo "Aplicando troca de donos (chown)..."
    # O usuário e o grupo criados passam a ser donos das pastas de dados sensíveis
    chown -R "$USUARIO":"$GRUPO" "$DIR_PRONTUARIOS"
    chown -R "$USUARIO":"$GRUPO" "$DIR_EXAMES"

    echo "Aplicando permissões restritivas (chmod)..."
    # Justificativa técnica: 
    # O chmod 770 garante que o dono (7) e o grupo (7) tenham acesso total.
    # Outros usuários do sistema (0) não terão acesso nenhum aos dados médicos.
    chmod -R 770 "$DIR_PRONTUARIOS"
    chmod -R 770 "$DIR_EXAMES"

    echo "[SUCESSO] Segurança e permissões aplicadas rigorosamente!"
    
    # Exibir a comprovação das permissões no terminal para a evidência do professor
    echo "---------------------------------------------------"
    echo "Auditoria das permissões aplicadas nos diretórios médicos:"
    ls -ld "$DIR_PRONTUARIOS"
    ls -ld "$DIR_EXAMES"
    echo "---------------------------------------------------"
}

configurar_seguranca