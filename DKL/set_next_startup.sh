

# Initiate Variables
CYCLE_PERIOD=10					# cycle length in minutes
NIGHT_START=22                  # Hour of the day at which recording is stopped
NIGHT_PERIOD=7                  # Length of night in hours
############################################################
# sync time web => rtc & pi

echo
echo "$(date +"%F %T"): Synchonising web time to RTC and RPi"
echo "HW clock read"
sudo hwclock -r
echo "HW clock write"
sudo hwclock -w
############################################################
# Set next startup time
	


# Read time variables
hour=$(date +%H)
#hour=22

# test
if test $hour -ge $NIGHT_START		# Night time check
	then 
	# Add night period to the current timestamp
	echo "$(date +"%F %T"): NIGHT TIME DETECTED"
	echo "DKL going to bed. Setting new startup time for next morning"
	sleep 20
	curl -H "Title: $(hostname)" -H "Tags: control_knobs"  -d "$(hostname) is going to bed. Setting new startup time for next morning $(date +"%a %d %b %H:00:00 %Z %Y" -d +"$NIGHT_PERIOD"hours)" ntfy.sh/$(hostname)
	python /home/pt/DKL/PJ/set_startup_morning.py $NIGHT_PERIOD
	# backup log file if it exceeds size limit
	/home/pt/DKL/LOG_backup.sh 
	else
	# Set normal cycle period
	echo "$(date +"%F %T"): Setting cycle period"
	python /home/pt/DKL/PJ/set_cycle_period.py $CYCLE_PERIOD
fi
############################################################

# Confirm next startup time
echo
echo "$(date +"%F %T"): Setting next startup has been completed________________________"
echo
