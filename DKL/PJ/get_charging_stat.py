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


# Read PiJuice status.
PJ_status=pj.status.GetStatus()
print('PiJuice charging status: 	' + str(PJ_status['data'].get('powerInput')))
	




