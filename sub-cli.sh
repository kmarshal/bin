#!/bin/bash

#
# Download and match movie subtitles from napisprojekt.pl. (cli)
#

if [ -z "$1" ]; then
	echo "Brak parametrów"
	exit 0;
fi;


file=`basename "$1"`
dir=`dirname "$1"`
len=${#file}
sub="${file:0:$len-3}txt"
subSrt="${file:0:$len-3}srt"
mplayerDump="dumpsub.sub"
execName=`basename "$0"` 

cd "$dir"
qnapi -c -q "$file"

if [ -f "$sub" ]; then
	mplayer -quiet -vo null -nosound -frames 0 -subcp cp1250 -dumpmicrodvdsub -sub "$sub" "$file" 2>/dev/null > /tmp/$execName.log

	if [ -f $mplayerDump ]; then
		rm "$sub"
		mv $mplayerDump "$subSrt"
		echo "Pobrano i dopasowano napisy. Plik: $subSrt"
	else 
		echo "Błąd konwersji mplayer"
	fi
else
	echo "Nie znaleziono napisów dla $file"
fi
