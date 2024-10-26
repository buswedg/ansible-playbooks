#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
CONFIG_FILE="$SCRIPT_DIR/config.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found: $CONFIG_FILE" >&2
    exit 1
fi

source "$CONFIG_FILE"

BACKUP_CMD="ansible-playbook $BACKUP_PLAYBOOK -e @$BACKUP_CONFIG"
JOB="$JOB_SCHEDULE $JOB_USER $BACKUP_CMD >> $LOG_FILE 2>&1"

if [ ! -f "$BACKUP_PLAYBOOK" ]; then
    echo "Backup playbook not found" >&2
    exit 1
fi

if ! sudo systemctl status cron &> /dev/null; then
    echo "Cron is not installed or not managed by systemd." >&2
    exit 1
fi

mkdir -p "$(dirname "$LOG_FILE")"
touch $LOG_FILE
chmod 0600 $LOG_FILE

if [ ! -f $CRON_FILE ]; then
    touch $CRON_FILE
    chmod 0644 $CRON_FILE
fi

grep -qxF "$JOB" $CRON_FILE || echo "$JOB" >> $CRON_FILE

sudo systemctl restart cron && \
if ! sudo systemctl is-active --quiet cron; then
    echo "Failed to restart cron service." >&2
    exit 1
fi
