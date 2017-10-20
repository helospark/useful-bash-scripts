# Compress a directory with multiple threads
#!/bin/bash

directory=${1%/}
output="$directory.tar.bz2"

if [ -f $output ]; then
    echo "$output already exists"
else
    tar -c $directory | pbzip2 -c > $output
fi
