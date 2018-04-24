# Fixing suspend for Ubuntu MATE 18.04
# Copy to /lib/systemd/system-sleep
#!/bin/sh

# Lock my screen after suspend
su username -c "XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0 dm-tool lock"

# Reinit the network driver after suspend
modprobe -r r8169;sudo modprobe r8169;
