# Converts video to mp4 with a relatively good quality.
# Run it like ./converter name height(800) quality(24) startTime endTime
#!/bin/bash
size=800
quality=24

if [ "$#" -lt 1 ]
then
	echo "./converter name height(800) quality(24) startTime endTime"
	exit
fi

if [ "$#" -ge 2 ]
then
	size=$2
fi

if [ "$#" -ge 3 ]
then
	quality=$3
fi

#echo "$size $quality"
if [ "$#" -le 3 ]
then
	ffmpeg -i "$1" -acodec aac -strict -2 -b:a 128k -vcodec libx264 -preset slow -crf $quality -vf scale=$size:-1 "$1.mp4"
fi

if [ "$#" -eq 4 ]
then
	starttime=$4
	ffmpeg -ss $starttime -i "$1" -acodec aac -strict -2 -b:a 128k -vcodec libx264 -preset medium -crf $quality -vf scale=$size:-1 "$1.mp4"
fi

if [ "$#" -eq 5 ]
then
	starttime=$4
	endtime=$5
	let startSecs=`echo "$starttime" | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }'`
	let endSecs=`echo "$endtime" | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }'`
	echo "$startSecs $endSecs"
	let length=$endSecs-$startSecs
	ffmpeg -ss $starttime -t $length -async 1 -i "$1" -acodec aac -strict -2 -b:a 128k -vcodec libx264 -preset medium -crf $quality -vf scale=$size:-1 "$1.mp4"
fi
