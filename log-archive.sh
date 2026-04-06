#!/bin/bash

#1. Verificar se o firetório foi passado como argumento
if [ -z "$1" ]; then
	echo "Uso: logo-archive <diretorio-de-logs>"
	exit 1
fi

LOG_DIR=$1
ARCHIVE_DEST="./archives"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
#2. Cria o diretório de destino, caso ele ainda não exista
mkdir -p "$ARCHIVE_DEST"

#3. COMPACTA OS LOGS
#-c criar, -z: compacta com gzip, -f: especifica o arquivo
tar -czf "${ARCHIVE_DEST}/${ARCHIVE_NAME}" "$LOG_DIR"

if [ $? -eq 0 ]; then
	echo "Logs de $LOG_DIR arquivados com sucesso em ${ARCHIVE_DEST}/${ARCHIVE_NAME}"
	
	#4 Registra a data e hora no arquivo de log
	echo "[$(date)] Arquivado: $ARCHIVE_NAME" >> archive_log.txt
else
	echo "Erro ao tentar compactar os logs"
	exit 1
fi

# -- FUNÇÃO PARA O CRON -- 

setup_cron(){
	echo ""
	read -r -p "Deseha agendar esse scrip para execução diária as 22:00? (s/n)" choice
        if [[ "$choice" == "s" || "$choice" == "S" ]]; then
		# PEGA O CAMINHO COMPLETO DE ONDE O SCRIP ESTÁ RODANDO AGORA
		SCRIPT_PATH=$(readlink -f "$0")
		# DEFINE A LINHA DE CRON (22h)
		CRON_LINE="0 22 * * * $SCRIPT_PATH /var/log"
		
		# Adiciona ao contrab sem apagar o que já existe lá
		(crontab -l 2>/dev/null; echo "$CRON_LINE") | crontab -
		echo "Agendamento conluído: $CRON_LINE"
	else
		echo "Agendamento Pulado."
	fi
}

# chamar a função de agendamento apenas se for rodado manualmente
if [ -t 0 ]; then
	setup_cron
fi

