#!/bin/bash

#Device name variable
if [ $1 = "dac" ]; then
	devicename="alsa_output.usb-FiiO_DigiHug_USB_Audio-01.analog-stereo"
elif [ $1 = "line-out" ]; then
	devicename="alsa_output.pci-0000_00_14.2.analog-stereo"
fi
echo "$devicename"

#change the default sink
pacmd "set-default-sink "$devicename""

#move all inputs to the new sink
for app in $(pacmd list-sink-inputs | sed -n -e 's/index:[[:space:]]\([[:digit:]]\)/\1/p');
do
	pacmd "move-sink-input $app "$devicename""
done
