#!/bin/sh

# With Ubuntu 20.04 lock after suspend is much worse than it was with 18.04, it's best to also install xscreensaver and start both xscreensaver and the other screensaver at the same time, doubling the chances that the screen will be locked.
# Copy to /lib/systemd/system-sleep/fixsuspend.sh and make executable

echo "Script is executing###"
# Lock my screen after suspend

killall mate-screensaver || echo "No mate-screensaver found"
# Make sure xscreensaver is running
isxscreesaverrunning=`ps aux | grep "xscreensaver" | grep -v "grep"`
if [ -z "$isxscreesaverrunning" ]
then
    echo "xscreensaver crashed, restarting"
    su REPLACE_USERNAME -c "xscreensaver -nosplash &"
fi
# Lock with xscreensaver too
su REPLACE_USERNAME -c "xscreensaver-command --lock"


check_file_pattern() {
  su REPLACE_USERNAME -c "xscreensaver-command --time | grep -q 'non-blanked'"
}

check_running_process() {
  su REPLACE_USERNAME -c 'ps aux | grep -q "screensaver"'
}

if check_file_pattern || ! check_running_process; then
  echo "xscreensaver failed me again, try the legacy method"
  su REPLACE_USERNAME -c "XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0 dm-tool lock"
  #XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0 dm-tool lock
else
  echo "xscreensaver is running properly"
fi

# Due to memory and cpu leak, let's restart every time
killall mate-indicator-applet-complete
