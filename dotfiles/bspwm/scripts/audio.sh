#!/bin/bash

if [ $(pacmd list | grep -w 'headphones.*available: no' | wc -c) -eq 0 ] 
then
	pacmd set-sink-port 0 analog-output-headphones
fi
