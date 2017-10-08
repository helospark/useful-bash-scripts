#!/bin/bash
# Converts media files to ogg using all available CPU threads
# Required GNU Parallel to be installed on the system

convert() {
	i=$1
	fileExtension=`echo "${i##*.}"`;
	newFileName=`echo "$i" | cut -d'.' --complement -f2-`;
	newFileName="$newFileName.ogg";
	if [ $fileExtension != "sh" ]
	then
		ffmpeg -loglevel panic -y -i "$i" -threads 4 -acodec libvorbis -vn "$newFileName"
		echo "Converted '$i' to '$newFileName'";
	fi
}
export -f convert

numberOfThreads=`grep -c ^processor /proc/cpuinfo`
if [ numberOfThreads == 0 ]
then
   numberOfThreads=2
fi
echo "Processing with $numberOfThreads threads..."
ls | parallel --gnu --no-notice -j 4 convert {}
