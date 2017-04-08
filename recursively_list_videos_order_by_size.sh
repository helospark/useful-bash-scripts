# List video files under the current folder recursively ordered by bytes/second.
# Useful for finding videos that has poor compression (for example short videos with large size)
# Usage: Just run it in the folder under which you want to check videos
#!/bin/bash
while read -rd $'\0' file; do
	i="$file";
	ff=$(ffmpeg -i "$i" 2>&1)
	d="${ff#*Duration: }"
	length=`echo "${d%%,*}"`
	let lengthSecond=`echo "$length" | awk -F'[:.]' '{ print ($1 * 3600) + ($2 * 60) + $3 }'`
	let size=`stat -c%s "$i"`
	sizeInMb=`echo "scale=3; $size/(1024*1024)" | bc`
	lengthInMinute=`echo "scale=2; $lengthSecond/(60)" | bc`
	if [ $lengthSecond -eq 0 ]
	then
		echo "0 $i length is 0"
	else
		let bitRate=$size/$lengthSecond
		echo -e "$bitRate $i \t\t\t $sizeInMb Mb \t\t\t $lengthInMinute min"
	fi
done < <(find  . -type f -name '*.*' -print0)
