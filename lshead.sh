# Clever combination of 'ls' and 'head' to see the most recently modified files. For example list the most recent log is accomplished by 'lshead /var/log'.
# You should copy this file to a folder pointed by PATH, like /bin/lshead
# Additional useful flags also included: human readable, list all files, long format
#!/bin/bash
if [ "$#" -eq 1 ]; then
	ls -lath | head -n $1
else
	ls -lath | head -n 40
fi
