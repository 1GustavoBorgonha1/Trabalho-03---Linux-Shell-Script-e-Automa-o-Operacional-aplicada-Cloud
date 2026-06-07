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
cd scripts
./menu.sh
```

---

### Acesse a aplicação web

Após executar a opção de Deploy no menu interativo, abra no navegador:

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

## Funcionalidades do Sistema

- Painel interativo de administração via terminal (CLI)
- Deploy automatizado de interface estática no Apache
- Backup de dados com compactação tar.gz e versionamento temporal
- Monitoramento de recursos de hardware (CPU, RAM e Disco)
- Gerenciamento e encerramento de processos ativos
- Segurança restritiva em pastas sensíveis com chmod 770

---

## Objetivo Acadêmico

Este projeto foi desenvolvido com foco em:

- Automação de processos operacionais através de Shell Script
- Conteinerização de ambientes Linux
- Configuração e provisionamento de servidores Apache
- Implementação de políticas de permissões e segurança Unix
- Versionamento e entrega contínua local

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
