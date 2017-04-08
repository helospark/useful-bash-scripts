# Run aurodump to capture traffic in the background with wlan0
# Run it like: ./run_airodump_in_background.sh filename
# This also requires a custom compiled airodump, otherwise it will use up 100% of the CPU, you should apply the following (if not already in master):
# https://dev.openwrt.org/attachment/ticket/22064/check_not_a_term.diff
#    7015 - if( pthread_create( &(G.input_tid), NULL, (void *) input_thread, NULL ) != 0 ) 
#    7015 + if( isatty(fileno(stdin)) )... // Creates the thread for user input ONLY if it's on a terminal 
# You can start this via ssh and just exit
#!/bin/bash
if [ $# -ne 1 ]; then
	echo -e "Usage:\nrun.sh filename"
	exit
fi

result=`ifconfig | grep "wlan0mon"`

if [ "$result" == '' ]; then
	airmon-ng start wlan0
fi
# Channel change seems necessary for some Wifi devices, otherwise sometimes they stuck :/
# Change channels to monitor
airodump-ng wlan0mon --cswitch 2 --channel 1,6,11 -f 120000 --write $1 > /dev/null 2>&1 &

disown -a
