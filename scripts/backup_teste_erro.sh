#!/bin/bash

# Diretorios utilizados no backup
ORIGEM="$HOME/tcc/experimentos/origem/"
DESTINO="/dev/null/"
LOG="$HOME/tcc/logs/backup.log"

# Registra o início do backup
echo "[$(date '+%d/%m/%Y %H:%M:%S')] Iniciando backup..." >> "$LOG"


# Executa o backup
rsync -av --stats "$ORIGEM" "$DESTINO"

# Armazena o codigo de saida do rsync
RESULTADO=$?

# Verifica se o backup foi concluido
if [ "$RESULTADO" -eq 0 ]; then
	echo "[$(date '+%d/%m/%Y %H:%M:%S')] Backup concluido com sucesso." >> "$LOG"

else
	echo "[$(date '+%d/%m/%Y %H:%M:%S')] ERRO no backup. Codigo: $RESULTADO" >> "$LOG"
fi

# Retorna o codigo de saida do rsync
exit "$RESULTADO"
