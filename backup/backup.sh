#!/bin/bash

DB_NAME="wordpress_db"
TABLE_NAME="wp_posts"
BACKUP_DIR="/home/aria/docker/dashboard-evp/backup"
DATE=$(date +%F-%H%M)
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_${TABLE_NAME}-$DATE.sql"

# Buat folder backup jika belum ada
mkdir -p "$BACKUP_DIR"

# Backup tabel tertentu pakai .my.cnf
mysqldump --defaults-extra-file=$HOME/.my.cnf -h 127.0.0.1 -P 3306 "$DB_NAME" "$TABLE_NAME" > "$BACKUP_FILE"

# Upload ke cloud pakai rclone
rclone copy "$BACKUP_FILE" remote:backup/mysql --log-file="/var/log/rclone_backup.log" --log-level=INFO
