#from __future__ import print_function

import time
import pijuice
import subprocess
import datetime
import os
import sys 

# This script is started at reboot by cron.
# Since the start is very early in the boot sequence we wait for the i2c-1 device
while not os.path.exists('/dev/i2c-1'):
	time.sleep(0.1)

try:
	pj = pijuice.PiJuice(1, 0x14)
except:
	print("Cannot create pijuice object")
	sys.exit()


# Read PiJuice battery status.
PJ_chargelevel=pj.status.GetChargeLevel()
print('PiJuice battery charge level: 	' + str(PJ_chargelevel['data']) + ' %')
#PJ_temperature=pj.status.GetBatteryTemperature()
#print('PiJuice battery temperature: 	' + str(PJ_temperature['data']) + ' °C')
PJ_voltage=pj.status.GetBatteryVoltage()
print('PiJuice battery voltage: 	' + str(PJ_voltage['data']) + ' mV')
#PJ_current=pj.status.GetBatteryCurrent()
#print('PiJuice battery current: 	' + str(PJ_current['data']) + ' mA')




