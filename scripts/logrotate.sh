#!/bin/sh

# Pfad zur Log-Datei
LOG_PATH="/var/log"
MESSAGES="${LOG_PATH}/messages"
BACKUP="${LOG_PATH}/messages_$(date '+%Y%m%d_%H%M%S').gz"
# Komprimiere die aktuelle Log-Datei mit einem Zeitstempel im Dateinamen
gzip -c $MESSAGES >$BACKUP
chown admin:docker $BACKUP 
# Lösche die Original-Log-Datei
rm $MESSAGES

# Sende dem syslog-Daemon ein HUP-Signal, um ihn dazu zu bringen, eine neue Log-Datei zu erstellen
pkill -HUP rsyslogd
sleep 5
chown admin:docker $MESSAGES
echo "Log rotation completed: $(ls -l $LOG_PATH )"

