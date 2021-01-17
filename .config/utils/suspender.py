#!/usr/bin/python

import os
import re
import sys
import time
import subprocess

min = 10


print('computer will suspend at ' + str(min) + '% of battery remaining...')

try:
	while True:
		(acpi, err) = subprocess.Popen('acpi', stdout=subprocess.PIPE, shell=True).communicate()
		try:
			bat = int(re.compile(r"[0-9]{2}%+").findall(str(acpi))[0][:2])
		except IndexError:
			bat = int(re.compile(r"[0-9]{1}%+").findall(str(acpi))[0][:1])
		print(str(bat) + '% of battery remaining')
		if bat <= min:
			break
		time.sleep(60)
	print('suspending...')
	os.system('notify-send "Computer will suspend in 5 seconds"' )
	time.sleep(5)
	os.system('systemctl suspend')
except KeyboardInterrupt:
	print()
	pass
