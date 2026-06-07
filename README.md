# Trabalho 03 - Infraestrutura Cloud e DevOps (Clínica Veterinária)

Sistema de infraestrutura web para hospedagem e administração do painel de uma clínica veterinária, desenvolvido como projeto acadêmico da 7ª fase de Sistemas de Informação na Unidavi, utilizando containers com Docker, servidor Apache e automação em Shell Script.

---

## Tecnologias Utilizadas

- Frontend: HTML5, CSS3 e JavaScript (Dashboard em Dark Mode)
- Servidor Web: Apache2
- Automação: Shell Script (Bash)
- Infraestrutura: Docker, Docker Compose e Ubuntu 22.04 LTS

---

## Arquitetura do Projeto

O sistema é focado na automação de processos e provisionamento, estruturado no seguinte serviço principal:

### Servidor Web e Automação (trabalho03-linux)
Container Ubuntu responsável por hospedar o servidor web Apache e executar todas as rotinas administrativas de Bash Script.

O container espelha os dados locais para garantir persistência através de mapeamento de volume:

```bash
.:/app
```

---

## Estrutura do Projeto

```bash
Trabalho-03/
|
|-- backups/
|-- clinica_vet/
|   |-- exames/
|   |-- pacientes/
|   |-- prontuarios/
|-- evidencias/
|-- logs/
|-- scripts/
|   |-- 01_update.sh
|   |-- 02_apache.sh
|   |-- 03_estrutura.sh
|   |-- 04_backup.sh
|   |-- 05_deploy.sh
|   |-- 06_processos.sh
|   |-- 07_monitoramento.sh
|   |-- 08_usuarios_permissoes.sh
|   |-- 09_relatorio.sh
|   |-- menu.sh
|-- source/
|-- docker-compose.yml
|-- Dockerfile
|-- README.md
```

---

## Explicação de cada script

### 01_update.sh
Atualiza as listas de pacotes e repositórios do sistema operacional Ubuntu de forma automática, direcionando a saída técnica para o histórico de logs.

### 02_apache.sh
Realiza a instalação e ativação do servidor web Apache2 e do pacote ImageMagick, validando o correto funcionamento do serviço de rede.

### 03_estrutura.sh
Cria a árvore física de diretórios dedicados da clínica dentro de /app/clinica_vet/ (prontuarios, exames e pacientes), limpando registros temporários antigos.

### 04_backup.sh
Compacta os arquivos da clínica em um arquivo consolidado no formato .tar.gz, aplicando marcação temporal dinâmica (data e hora) no nome do arquivo final.

### 05_deploy.sh
Executa a limpeza da pasta pública padrão do Apache, publica a versão mais recente do dashboard contido em source/ e valida a integridade do arquivo index.html.

### 06_processos.sh
Oferece funções interativas para buscar, listar e encerrar serviços por PID, contendo uma trava de segurança que bloqueia o encerramento se nenhum número de processo for passado.

### 07_monitoramento.sh
Captura dados em tempo real sobre o uso de CPU, memória RAM e Disco do servidor, disparando alertas visuais caso os níveis ultrapassem o limite crítico de 80%.

### 08_usuarios_permissoes.sh
Cria o grupo equipe_veterinaria e o usuário administrador vet_admin. Substitui o uso inseguro de chmod 777 por permissões restritivas chmod 770 para blindar dados médicos.

### 09_relatorio.sh
Coleta dados técnicos do hardware, caminhos de rede e status dos logs operacionais, exportando uma auditoria consolidada para um arquivo de texto.

### menu.sh
Fornece uma interface em formato de menu interativo no terminal, centralizando o acesso e a execução simplificada das opções de 1 a 9.

---

## Como executar o projeto localmente

### Pré-requisitos

Antes de começar, instale:

- Docker
- Docker Compose

---

### Clone o repositório

```bash
git clone https://github.com/1GustavoBorgonha1/Trabalho-03---Linux-Shell-Script-e-Automa-o-Operacional-aplicada-Cloud.git
```

---

### Acesse a pasta do projeto

```bash
cd Trabalho-03---Linux-Shell-Script-e-Automa-o-Operacional-aplicada-Cloud
```

---

### Execute os containers

```bash
sudo docker compose up -d --build
```

---

### Acesse o painel de automação (Terminal)

```bash
sudo docker exec -it trabalho03-linux bash
```

---

### Como executar o menu principal

Uma vez dentro do terminal do container, acesse o caminho correspondente e chame a interface:

```bash
cd scripts
./menu.sh
```

---

### Como executar cada script individualmente

Para rodar os procedimentos administrativos de forma isolada, garanta a permissão com `chmod +x *.sh` e execute:

- Atualização: `./01_update.sh`
- Apache: `./02_apache.sh`
- Estrutura: `./03_estrutura.sh`
- Backup: `./04_backup.sh`
- Deploy: `./05_deploy.sh`
- Processos: `./06_processos.sh [listar | buscar nome | matar PID]`
- Monitoramento: `./07_monitoramento.sh`
- Segurança: `./08_usuarios_permissoes.sh`
- Relatório: `./09_relatorio.sh`

---

### Como acessar o Apache no navegador

Após executar a opção de Deploy (Opção 5) através do painel interativo, o servidor disponibilizará o sistema no endereço:

```bash
http://localhost:8080
```

---

## Como parar a aplicação

Para parar o container e encerrar a rede:

```bash
sudo docker compose down
```

---

## Persistência de Dados

O projeto utiliza um volume Docker espelhado com o diretório local para manter o estado da aplicação. 

A estrutura isola os prontuários e exames médicos no seguinte caminho protegido:

```bash
/app/clinica_vet
```

Isso garante que os arquivos físicos, logs e backups não sejam perdidos mesmo após reiniciar a infraestrutura.

---

## Evidências de funcionamento

Todas as capturas de tela exigidas para homologação técnica e auditoria visual da infraestrutura estão armazenadas em formato de imagem dentro do seguinte diretório do repositório:

```bash
/evidencias
```

O conteúdo engloba os testes individuais de cada comando Bash, logs gerados, container ativo e a renderização correta do dashboard no navegador.

---

## Principais dificuldades encontradas

- Adaptação dos comandos de inicialização e monitoramento de serviços em um ambiente conteinerizado enxuto, substituindo chamadas baseadas no Systemd (systemctl) pelo comando nativo service.
- Configuração do pipeline de deploy local para assegurar que a clonagem da interface web ficasse perfeitamente alocada na raiz pública do Apache (/var/www/html), evitando subpastas aninhadas que quebravam o mapeamento do servidor.

---

## Uso de Inteligência Artificial

A Inteligência Artificial foi utilizada como ferramenta de suporte técnico e mentoria acadêmica ao longo do projeto. O uso concentrou-se no auxílio para a estruturação sintática de manipulação de strings com awk e sed na coleta de métricas, na modelagem lógica do menu interativo e na revisão de regras de segurança Unix. 

Todos os testes de volume, caminhos absolutos no Docker, amarração do cenário de clínica veterinária e aplicação prática das políticas restritivas 770 foram executados e validados manualmente em ambiente local, garantindo a compreensão e o aprendizado prático da arquitetura desenvolvida.

---

## Imagem Pública no DockerHub

A imagem Docker da infraestrutura foi publicada no DockerHub e pode ser acessada pelo link abaixo:

https://hub.docker.com/r/gustavoborgonha/clinica-vet-cloud-infra

### Baixar a imagem manualmente

```bash
docker pull gustavoborgonha/clinica-vet-cloud-infra:v1
```

---

## Autor

Desenvolvido por Gustavo Borgonha

### Repositório do Projeto

https://github.com/1GustavoBorgonha1/Trabalho-03---Linux-Shell-Script-e-Automa-o-Operacional-aplicada-Cloud.git
