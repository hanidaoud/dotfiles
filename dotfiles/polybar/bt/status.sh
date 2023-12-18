#!/bin/bash
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
	echo "%{F#66ffffff}"
else
	if [ $(bluetoothctl devices | cut -f2 -d' ' | while read uuid; do bluetoothctl info $uuid; done|grep -e "Device\|Connected\|Name" | grep "Connected: yes" | wc -c) -eq 0 ]
	then
		if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
		then
			echo ""
		fi
		echo "%{F#2193ff}"
	else
		echo "%{F#2193ff}%{T3}%{T-}%{T1}$(bluetoothctl info | grep "Name" | cut -d\: -f2)%{T-}"
	fi
fi
