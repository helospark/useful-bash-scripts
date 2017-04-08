# Find the given string in the contents of any of the files under the current location recursively.
# You should copy it to a location PATH points to (like /bin/findinfiles.sh)
# Usage to find any failed logs, go to /var/log and
# findinfiles failed
#!/bin/bash
grep -rnw '.' -e "$1"

