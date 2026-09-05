#!/bin/bash

BACKUP_DIR="/tmp"
SOURCE="/var/www/html"
BUCKET="s3://amazonkart-backup-2026-28-08/daily"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
FILE="$BACKUP_DIR/amazonkart-web-$DATE.tar.gz"
LOG="/var/log/amazonkart-backup.log"

tar -czf "$FILE" "$SOURCE"

if aws s3 cp "$FILE" "$BUCKET/"; then
    echo "$(date) Backup SUCCESS: $FILE" >> "$LOG"
    rm -f "$FILE"
else
    echo "$(date) Backup FAILED: $FILE" >> "$LOG"
fi
