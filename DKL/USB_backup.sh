#!/bin/sh

# MOVE UPLOADED FILES TO USB

# Initiate Variables
CONN_DATE=$(date +%Y%m%d_%H%M)		# date and time of connection without seconds
USB_PATH=/media/pt/DKL_USB/		# date and time of connection without seconds

# START________________________
echo
echo "$(date +"%F %T"): Initiating USB backup"
echo

# create new folder and copy files to USB drive
tree /home/pt/Videos/
echo

echo "$(date +"%F %T"): Creating new folder on USB drive and copying files from Videos directory to USB drive"
sudo mkdir $USB_PATH$CONN_DATE
sudo cp /home/pt/Videos/* $USB_PATH$CONN_DATE
tree /media/pt/DKL_USB/$CONN_DATE

# clean directory
echo "cleaned up Videos directory"
sudo rm /home/pt/Videos/*
tree /home/pt/Videos/

# END________________________
echo
echo "$(date +"%F %T"): USB backup completed________________________"
echo
