# Converts all video files (technically non sh files) in the current directory to ogg music files.
# Just run the current script without argument in the same folder as there are the videos.
#!/bin/bash

for i in *
do
	fileExtension=`echo "${i##*.}"`;
	newFileName=`echo "$i" | cut -d'.' --complement -f2-`;
	newFileName="$newFileName.ogg";
	if [ $fileExtension != "sh" ]
	then
		echo "CONVERTING $i newFileName: $newFileName";
		ffmpeg -i "$i" -acodec libvorbis -vn "$newFileName"
	fi
done
