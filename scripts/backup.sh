#!/bin/bash

# Diretorios utilizados no backup
ORIGEM="$HOME/tcc/experimentos/origem/" DESTINO="$HOME/tcc/experimentos/backup_rsync/" LOG="$HOME/tcc/logs/backup.log"

# Registra o início do backup
echo "[$(date '+%d/%m/%Y %H:%M:%S')] Iniciando backup..." >> "$LOG"


# Registra o instante inicial
INICIO=$(date +%s%N)

# Executa o backup
SAIDA=$(rsync -av --stats "$ORIGEM" "$DESTINO" 2>&1)

# Armazena o codigo de saida do rsync
RESULTADO=$?

# Registra instante final da execucao do rsync
FIM=$(date +%s%N)

# Exibe a saida do rsync no terminal
printf '%s\n' "$SAIDA"

# Extrai a quantidade de arquivos transferidos
ARQUIVOS=$(printf '%s\n' "$SAIDA" | awk -F': ' '/Number of regular files transferred:/ {print $2}')

# Extrai a quantidade de bytes transferidos
BYTES=$(printf '%s\n' "$SAIDA" | awk -F': ' '/^Total transferred file size:/ {gsub(/[^0-9]/, "", $2); print $2}')


# Calcula a duracao em milissegundos
DURACAO=$(( (FIM - INICIO) / 1000000 ))

# Registra as metricas da execucao no CSV
printf '%s,%s,%s,%s,%s\n' \
	"$(date '+%Y-%m-%d %H:%M:%S')" \
	"$DURACAO" \
	"$ARQUIVOS" \
	"$BYTES" \
	"$RESULTADO" >> "$HOME/tcc/logs/metricas.csv"
echo "[$(date '+%d/%m/%Y %H:%M:%S')] Duracao do backup $DURACAO ms" >> "$LOG"


# Verifica se o backup foi concluido
if [ "$RESULTADO" -eq 0 ]; then
	echo "[$(date '+%d/%m/%Y %H:%M:%S')] Backup concluido com sucesso." >> "$LOG"

else
	echo "[$(date '+%d/%m/%Y %H:%M:%S')] ERRO no backup. Codigo: $RESULTADO" >> "$LOG"
fi

# Retorna o codigo de saida do rsync
exit "$RESULTADO"
