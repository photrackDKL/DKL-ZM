# libraries
import time
import pijuice
import subprocess
import datetime
from datetime import timedelta
import os
import sys 

# Variables
DELTA_HOURS = int(sys.argv[1])		# Length of night in hours given as input argument
pj_alarm = {}						# Alarm variable for PiJuice

# This script is started at reboot by cron. Since the start is very early in the boot sequence we wait for the i2c-1 device
while not os.path.exists('/dev/i2c-1'):
	time.sleep(0.1)

try:
	pj = pijuice.PiJuice(1, 0x14)
except:
	print("Cannot create pijuice object")
	sys.exit()


# Set RTC alarm DELTA_HOURS hours from now
# RTC is kept in UTC

# Calculate morning startup time
next_time = datetime.datetime.utcnow() + timedelta(hours=DELTA_HOURS)
print("Next startup time (UTC time): " + str(next_time))
# set variable for PiJuice
#a['year'] = (next_time.year)
#a['month'] = (next_time.month)
pj_alarm['day'] = (next_time.day)
pj_alarm['hour'] = (next_time.hour)
pj_alarm['minute'] = 0
pj_alarm['second'] = 0

# Enable wakeup, otherwise power to the RPi will not be applied when the RTC alarm goes off
pj.rtcAlarm.SetWakeupEnabled(True)
# Set alarm on PiJuice
status = pj.rtcAlarm.SetAlarm(pj_alarm)

# check if alarm was set successfully
if status['error'] != 'NO_ERROR':
	print('Cannot set alarm\n')
	sys.exit()
else:
	print('Wake up enabled:	' + str(pj.rtcAlarm.GetControlStatus()['data'].get('alarm_wakeup_enabled')))
	print('Alarm set on PiJuice: \n day: 		' + str(pj.rtcAlarm.GetAlarm()['data'].get('day')) + '\n weekday: 	' + str(pj.rtcAlarm.GetAlarm()['data'].get('weekday')) + '\n hour: 		' + str(pj.rtcAlarm.GetAlarm()['data'].get('hour')) + '\n minute: 	' + str(pj.rtcAlarm.GetAlarm()['data'].get('minute')) + '\n mins period:	' + str(pj.rtcAlarm.GetAlarm()['data'].get('minute_period')) + '\n second: 	' + str(pj.rtcAlarm.GetAlarm()['data'].get('second')))


