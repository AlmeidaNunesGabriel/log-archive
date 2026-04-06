

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