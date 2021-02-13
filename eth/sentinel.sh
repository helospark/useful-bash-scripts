# Ethminer randombly stops mining for random issues, about once per 1-2 weeks. Could be network issue or bug in ethminer that exists on Linux
# Ethminer process do not exit on (some) errors event when --exit is specified, this script is to monitor and kill the process if it is stuck.
# Usage: start both start.sh and sentinel.sh at the same time in 2 different terminals
#/bin/bash

last=

sleep 60

while true
do
  output=`tail -n 10 output.log | grep Mh` # Will not work in gigahash range :D 
  #echo $output
  count=`echo $output | wc -l`

  if [ "$count" -eq "0" ] || [ "$output" = "$last" ]; then
    echo -n "RESTART REQUIRED c=$count\n o=$output\n l=$last\n"
    pid=`ps aux | grep ethminer | grep "stratum" | awk '{print $2}'`
    kill $pid
    sleep 5
    kill -9 $pid
    sleep 80
  else
    echo "All is good $count"
  fi

  last=$output
  sleep 5
done
