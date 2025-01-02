#!/bin/bash

# Configuration
SOURCE_FOLDER="/root/source_folder/"
TARGET_FOLDER="/var/www"
BACKUP_FOLDER="/var/www_backup"
LOG_FILE="/var/log/backup_www.log"
DATE=$(date +'%Y-%m-%d_%H-%M-%S')

# Create a backup of the current /var/www folder
echo "[$DATE] Starting backup of $TARGET_FOLDER" | tee -a "$LOG_FILE"
if [ -d "$TARGET_FOLDER" ]; then
    mkdir -p "$BACKUP_FOLDER/$DATE"
    cp -R "$TARGET_FOLDER"/* "$BACKUP_FOLDER/$DATE" && \
    echo "[$DATE] Backup completed successfully at $BACKUP_FOLDER/$DATE" | tee -a "$LOG_FILE"
else
    echo "[$DATE] Error: $TARGET_FOLDER does not exist. Aborting backup." | tee -a "$LOG_FILE"
    exit 1
fi

# Copy new files into the /var/www folder
echo "[$DATE] Copying new files from $SOURCE_FOLDER to $TARGET_FOLDER" | tee -a "$LOG_FILE"
if [ -d "$SOURCE_FOLDER" ]; then
    cp -R "$SOURCE_FOLDER"/* "$TARGET_FOLDER" && \
    echo "[$DATE] Files copied successfully." | tee -a "$LOG_FILE"
else
    echo "[$DATE] Error: $SOURCE_FOLDER does not exist. Aborting file copy." | tee -a "$LOG_FILE"
    exit 1
fi

echo "[$DATE] Operation completed." | tee -a "$LOG_FILE"
