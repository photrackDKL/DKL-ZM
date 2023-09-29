#!/bin/sh

# FTPs connect and upload content

# Initiate Variables
CONN_USR="DKrpi"
CONN_PWD="DischargeKeeperRPI12"
FTP_URL="wl37www620.webland.ch"
DKL_NAME=$(hostname)

REM_DIR="/"$DKL_NAME"_vid"
VID_PATH="/home/pt/Videos/"

# UPLOAD____________________________________________________________________
echo
echo "$(date +"%F %T"): Initiating FTP connection to upload videos \n"
lftp -c "open -u $CONN_USR,$CONN_PWD $FTP_URL; mput -O $REM_DIR $VID_PATH*" 
echo "$(date +"%F %T"): video upload completed"
echo

# CHECK_____________________________________________________________________
echo "$(date +"%F %T"): checking upload directory contents (listing last 4 entries)"
lftp -e "cd $REM_DIR;ls -1t | tail -4; exit" -u $CONN_USR,$CONN_PWD $FTP_URL
echo

# Finish statement
echo "$(date +"%F %T"): FTP upload completed________________________"
# Notification
#curl -H "Title: DKL RPI00" -H "Tags: clapper,arrow_double_up" -d "Video file uploaded" ntfy.sh/$DKL_NAME
echo
