#!/bin/sh


# download interrupt configuration file from FTP server and check wether to halt poweroff sequence

# Initiate Variables
CONN_USR="DKrpi"
CONN_PWD="DischargeKeeperRPI12"
FTP_URL="wl37www620.webland.ch"
DKL_NAME=$(hostname)

REM_FILE_PATH="/interrupt/"$DKL_NAME"_interrupt"
LOC_FILE_PATH="/home/pt/DKL/interrupt"


# START________________________
echo
echo "$(date +"%F %T"): Initiating FTP connection to download interrupt file from FTPE server\n"

# download interrupt file and move it to subfolder on the FTP server
timeout -k 2 30s lftp -e "get $REM_FILE_PATH -o $LOC_FILE_PATH; mmv $REM_FILE_PATH /interrupt/trigger_files; exit" -u $CONN_USR,$CONN_PWD $FTP_URL

# remove interrupt file on FTP server

# check interrupt file
echo "$(date +"%F %T"): checking interrupt file \n"


# in on mode move poweroff.sh, start teamviewer and send email
if head $LOC_FILE_PATH | grep -q "ON"
then
	# confirm maintenance mode
	echo "$(date +"%F %T"): $DKL_NAME going into maintenance mode"
	
	#remove interrupt file locally
	echo "$(date +"%F %T"): Removing local interrupt file"
	rm $LOC_FILE_PATH
	
	# turn on Teamviewer
	echo "$(date +"%F %T"): Starting Teamviewer"
	systemctl start teamviewerd.service
	
	# send notification
	echo "$(date +"%F %T"): Sending notification"
	curl -H "Title: $DKL_NAME" -H "Tags: control_knobs,calling"  -d "$DKL_NAME is in maintenance mode. Ready to connect over TeamViewer!" ntfy.sh/$DKL_NAME
	
	#set reboot timeout if nobody connects after 30 minutes
	echo "$(date +"%F %T"): Setting poweroff timeout if nobody connects after 30 minutes"
	sudo shutdown -r +30
	# show scheduled shutdown time
	if [ -f /run/systemd/shutdown/scheduled ]; then   perl -wne 'm/^USEC=(\d+)\d{6}$/ and printf("Shutting down at: %s\n", scalar localtime $1)' < /run/systemd/shutdown/scheduled; fi
	
	# set sleep so DKL is powered off before software shutdown can be triggered in run_DKL.sh (
	sleep 31m	#(31+ minutes)
else
	# continue in cycle mode
	echo "$(date +"%F %T"): $DKL_NAME continues in cycle mode"	
	echo
fi


# END________________________
echo "$(date +"%F %T"): check interrupt completed________________________"
echo
