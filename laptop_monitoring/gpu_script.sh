#!/bin/bash

while true; do
    data=`timeout 2 intel_gpu_top -l | grep -v "Freq"`

    #echo $data
    #echo ""

    gpuPower=`echo $data | cut -d' ' -f45`
    pkgPower=`echo $data | cut -d' ' -f46`
    freq=`echo $data | cut -d' ' -f42`

    d=`date "+%s"`

    echo "pow=$gpuPower, pkg=$pkgPower, freq=$freq"

    echo "collectd.black.gpu.power $gpuPower $d" | nc -q0 localhost 12005
    echo "collectd.black.cpu.power $pkgPower $d" | nc -q0 localhost 12005
    if [ "$variable" != "0" ]; then
        echo "collectd.black.gpu.freq $freq $d" | nc -q0 localhost 12005
    fi
    
    tabs=`python3 count_tabs.py`
    echo "firefox.tabs.count $tabs $d" | nc -q0 localhost 12005
    
    battery=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/percentage:/ {print +$2}'`
    
    echo "battery.percent" $battery $d | nc -q0 localhost 12005
    
    temperature=`sensors -j | jq '."coretemp-isa-0000"."Package id 0".temp1_input'`
    
    echo "collectd.black.cpu.temperature" $temperature $d | nc -q0 localhost 12005

    sleep 60
done
