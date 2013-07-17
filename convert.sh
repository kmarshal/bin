#!/bin/bash
dir="resized"
if [ ! -d $dir ]; then
	mkdir $dir
fi

function resize {
	counter=1
	args_count=$#
	for i in "$@"
	do
		file=`basename "$i"`
		convert "$i" -resize 1280x1280\> -quality 90 "$dir/$file" 2>/tmp/convert-err.log
		progress=$(echo "$counter / $args_count * 100" |bc -l)
		counter=$[counter + 1]
		echo $progress
	done
}

resize "$@" | zenity --progress --auto-close --title="Resize image" --text="Image resizing in progress..." --width=400
