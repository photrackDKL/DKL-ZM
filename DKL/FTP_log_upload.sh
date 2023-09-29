#!/bin/sh

# FTPs connect and upload

# Initiate Variables
CONN_DATE=$(date +%Y%m%d_%H%M%S)		# date and time of connection without seconds
CONN_USR="DKrpi"
CONN_PWD="DischargeKeeperRPI12"
FTP_URL="wl37www620.webland.ch"
DKL_NAME=$(hostname)

REM_DIR="/"$DKL_NAME"_log"
LOG_FILE_PATH="/home/pt/Desktop/"$DKL_NAME"_LOG.log"



# CONNECT_____________________________________________________________________


# Connect FTP
echo
echo "$(date +"%F %T"): Iniating FTP connection to upload LOG file"
lftp -c "open -u $CONN_USR,$CONN_PWD $FTP_URL; put -O $REM_DIR $LOG_FILE_PATH -o $DKL_NAME"_"$CONN_DATE.log"

# Terminate connection
echo "$(date +"%F %T"): FTP LOG upload completed________________________"
# Notification
curl -H "Title: $DKL_NAME" -H "Tags: clipboard,arrow_double_up" -d "Files uploaded!
🔋⚡️
$(python /home/pt/DKL/get_batt_V.py)" ntfy.sh/$DKL_NAME
echo
