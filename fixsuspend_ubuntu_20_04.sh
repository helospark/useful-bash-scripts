#!/bin/sh

# With Ubuntu 20.04 lock after suspend is much worse than it was with 18.04, it's best to also install xscreensaver and start both xscreensaver and the other screensaver at the same time, doubling the chances that the screen will be locked.

# Lock my screen after suspend
su REPLACE_WITH_YOUR_USERNAME -c "XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0 dm-tool lock"

# Make sure xscreensaver is running
isxscreesaverrunning=`ps aux | grep "xscreensaver" | grep -v "grep"`
if [ -z "$isxscreesaverrunning" ]
then
    echo "xscreensaver crashed, restarting"
    su REPLACE_WITH_YOUR_USERNAME -c "xscreensaver -nosplash &"
fi

# Lock with xscreensaver too
su REPLACE_WITH_YOUR_USERNAME -c "xscreensaver-command --lock"
