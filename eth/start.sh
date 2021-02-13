# Starts the ethminer and loops in case ethminer crashes.
# Usage: start both start.sh and sentinel.sh at the same time in 2 different terminals


# overclock settings if uncommented
#sudo su <<EOF
#echo "3" > /sys/class/drm/card0/device/pp_mclk_od
#echo "7" > /sys/class/drm/card0/device/pp_sclk_od
#EOF

STRATUM_URL=stratum1+ssl://REPLACEME

while true; do ./ethminer -P $STRATUM_URL 2>&1 | tee -a output.log ; echo "Restarting"; sleep 15; done
