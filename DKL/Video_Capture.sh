#!/bin/sh

# Capture and save video

# Initiate Variables
VID_LENGTH=5000						# video length in milliseconds
VID_PATH="/home/pt/Videos/"	# save file to USB drive
VID_DATE=$(date +%Y%m%d_%H%M%S)		# date and time of capture
VID_NAME="DKLRPI_$VID_DATE"	# video name string
VID_FORMAT=".mkv"					# video file format
VID_BPS=20000000					# video target bitrate in bits per second
VID_FPS=30							# video frame rate in frames per second

# RECORD___________________________________________________________________


# cmd output message
echo
echo "$(date +"%F %T"): Initiating Video Capture"
echo "Video of $VID_LENGTH seconds will be captured and stored as $VID_NAME$VID_FORMAT"

#record video and save in ~/Video dir
libcamera-vid --codec libav --level 4.2 --framerate $VID_FPS --bitrate $VID_BPS --width 1920 --height 1080 -t $VID_LENGTH --nopreview -o $VID_PATH$VID_NAME$VID_FORMAT

# Waits 2 seconds.
sleep 2s

# VERIFY___________________________________________________________________


# Verify files by using "stat" command
printf "\n \n New video file created:\n"
file /home/pt/Videos/$VID_NAME$VID_FORMAT
printf "\n file properties:\n"
stat /home/pt/Videos/$VID_NAME$VID_FORMAT
echo
# Copy Video to USB Drive


# cmd finish message
echo "$(date +"%F %T"): Video capture completed________________________"
echo

# record 1080p@60
#libcamera-vid --intra 60 --width 1920 --height 1080 -o test.h264
