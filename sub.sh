#!/bin/bash
if [ -z $1 ]; then
	zenity --info --text "Brak parametrów"
	exit 0;
fi;

file=`basename $1`
dir=`dirname $1`
len=${#file}
sub="${file:0:$len-3}txt"
subSrt="${file:0:$len-3}srt"
mplayerDump="dumpsub.sub"

cd $dir
qnapi -c -q $file

if [ -f $sub ]; then
	mplayer -quiet -vo null -nosound -frames 0 -subcp cp1250 -dumpmicrodvdsub -sub $sub $file

	if [ -f $mplayerDump ]; then
		rm $sub
		mv $mplayerDump $subSrt
		zenity --info --text "<b>Pobrano i dopasowano napisy.</b>\n\nPlik: $subSrt"
	else 
		zenity --warning --text "Błąd konwersji mplayer"
	fi
else
	zenity --warning --text "Nie znaleziono napisów dla $file"
fi
