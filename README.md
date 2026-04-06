
 (English version at the end.)
# 📦 Log Archive Tool

Este é um utilitário em **Shell Script** desenvolvido para automatizar o backup e a organização de arquivos de log em sistemas Linux. O script comprime diretórios, mantém um histórico de auditoria e permite o agendamento automático via `cron`.

Este projeto faz parte do Roadmap.sh/DevOps. *https://roadmap.sh/projects/log-archive-tool*

## 🚀 Funcionalidades

* **Compactação Gzip**: Reduz o tamanho dos logs para economizar espaço em disco.
* **Criação Dinâmica**: Garante a existência da pasta de destino antes da execução.
* **Logs de Auditoria**: Registra cada ação bem-sucedida em um arquivo de texto.
* **Automação Interativa**: Configura o agendamento no sistema sem necessidade de editar arquivos manualmente.

## 🛠️ Pré-requisitos

* Sistema Linux (Distribuições como Debian e Mint).
* Interpretador de comandos `Bash`.
* Permissões de escrita no diretório onde o script será executado.

## 📋 Como Utilizar

1. **Permissão de execução**:
   ```bash
   chmod +x log-archive.sh
   ```

2. **Execução manual**:
   Passe o diretório que contém os logs como o primeiro argumento:
   ```bash
   ./log-archive.sh /var/log
   ```

---

## 🔍 Detalhamento do Código (Passo a Passo)

Para fins didáticos, aqui está a explicação do que as principais linhas do script realizam:

### 1. Verificação de Argumentos
```bash
if [ -z "$1" ]; then ...
```
* O script verifica se você passou um diretório após o comando. Se a variável `$1` (primeiro argumento) estiver vazia, ele exibe uma mensagem de ajuda e encerra com erro (`exit 1`).

### 2. Definição de Variáveis e Data
```bash
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
```
* Utilizamos o comando `date` para gerar um carimbo de tempo único. Isso evita que um backup sobrescreva o outro.

### 3. O Comando de Compactação
```bash
tar -czf "${ARCHIVE_DEST}/${ARCHIVE_NAME}" "$LOG_DIR"
```
* **`-c`**: Cria um novo arquivo.
* **`-z`**: Comprime usando o algoritmo `gzip`.
* **`-f`**: Define o nome do arquivo final.

### 4. Agendamento com Crontab
```bash
(crontab -l 2>/dev/null; echo "$CRON_LINE") | crontab -
```
* Esta linha é muito importante: ela lê o agendamento atual do usuário (`crontab -l`), adiciona a nova linha de comando (`echo "$CRON_LINE"`) e envia tudo de volta para o sistema de agendamento. O `2>/dev/null` serve para não exibir erro caso o seu `crontab` ainda esteja vazio.

### 5. Verificação de Terminal Interativo
```bash
if [ -t 0 ]; then
    setup_cron
fi
```
* O comando `[ -t 0 ]` checa se o script está sendo rodado por um humano no terminal ou por um processo automático. Isso impede que o script "trave" esperando uma resposta de sim/não quando estiver rodando sozinho de madrugada.

---

## 📂 Estrutura de Arquivos

* `log-archive.sh`: O motor de automação.
* `archive_log.txt`: Onde o histórico de sucessos é armazenado.
* `/archives`: Pasta criada para guardar os arquivos `.tar.gz`.

---
Desenvolvido por **Gabriel Almeida Nunes**.

---

# 📦 Log Archive Tool

This is a **Shell Script** utility designed to automate the backup and organization of log files on Linux systems. The script compresses directories, maintains an audit history, and enables automatic scheduling via `cron`.

This project is part of the **Roadmap.sh/DevOps** curriculum. *[https://roadmap.sh/projects/log-archive-tool](https://roadmap.sh/projects/log-archive-tool)*

## 🚀 Features

* **Gzip Compression**: Reduces log size to save disk space.
* **Dynamic Creation**: Ensures the destination folder exists before execution.
* **Audit Logs**: Records every successful action in a text file.
* **Interactive Automation**: Configures system scheduling without the need for manual file editing.

## 🛠️ Prerequisites

* Linux System (Tested on distributions like **Debian** and **Mint**).
* **Bash** command interpreter.
* Write permissions in the directory where the script will be executed.

## 📋 How to Use

1. **Grant execution permission**:
   ```bash
   chmod +x log-archive.sh
   ```

2. **Manual execution**:
   Pass the directory containing the logs as the first argument:
   ```bash
   ./log-archive.sh /var/log
   ```

---

## 🔍 Code Breakdown (Step-by-Step)

For educational purposes, here is an explanation of what the main lines of the script do:

### 1. Argument Verification
```bash
if [ -z "$1" ]; then ...
```
* The script checks if you provided a directory after the command. If the variable `$1` (the first argument) is empty, it displays a help message and exits with an error (`exit 1`).

### 2. Variables and Date Definition
```bash
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
```
* We use the `date` command to generate a unique timestamp. This prevents one backup from overwriting another.

### 3. The Compression Command
```bash
tar -czf "${ARCHIVE_DEST}/${ARCHIVE_NAME}" "$LOG_DIR"
```
* **`-c`**: Create a new archive.
* **`-z`**: Compress using the `gzip` algorithm.
* **`-f`**: Defines the final filename.

### 4. Scheduling with Crontab
```bash
(crontab -l 2>/dev/null; echo "$CRON_LINE") | crontab -
```
* This line is crucial: it reads the user's current schedule (`crontab -l`), appends the new command line (`echo "$CRON_LINE"`), and sends everything back to the scheduling system. The `2>/dev/null` part ensures no error is shown if your `crontab` is currently empty.

### 5. Interactive Terminal Check
```bash
if [ -t 0 ]; then
    setup_cron
fi
```
* The `[ -t 0 ]` command checks if the script is being run by a human in the terminal or by an automated process. This prevents the script from "hanging" while waiting for a yes/no response when running automatically at night.

---

## 📂 File Structure

* `log-archive.sh`: The automation engine.
* `archive_log.txt`: Where the success history is stored.
* `/archives`: Folder created to store the `.tar.gz` files.

---
Developed by **Gabriel Almeida Nunes**.