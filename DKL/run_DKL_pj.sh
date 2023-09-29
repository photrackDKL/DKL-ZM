#!/bin/bash


# set wake up time
/home/pt/DKL/set_next_startup.sh 


# check interrupt
/home/pt/DKL/check_interrupt.sh


# capture video
/home/pt/DKL/Video_Capture.sh


# upload video to FTP server
# timeout the command after 150 seconds and kill process 2 seconds later to avoid FTP upload to take forever
timeout -k 2 150s /home/pt/DKL/FTP_video_upload.sh


# move Videos to USB disk
#mkdir /media/pt/DKL_USB; mount /dev/nvme0n1p1 /media/pt/DKL_USB/	# Mount NVME drive
/home/pt/DKL/USB_backup.sh 


# upload log file to FTP server
# timeout the command after 90 seconds and kill process 2 seconds later to avoid FTP upload to take forever
timeout -k 2 90s /home/pt/DKL/FTP_log_upload.sh


# turn off
echo
echo "Calling software shutdown in 15 seconds"
sleep 15; 
echo "--------------------------------------------------------------------"
sudo shutdown -h now

