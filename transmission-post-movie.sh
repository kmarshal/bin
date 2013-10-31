#!/bin/bash

#
# Download movie subtitles from napiprojekt.pl after torrent finished
#

tdir=$TR_TORRENT_DIR
tname=$TR_TORRENT_NAME
tfile="$tdir/$tname"
script=`basename $0`
log="logger -t $script"

function download_subtitles {
	type=`file -bi "$1"`
	$log "Sprawdzanie pliku:'$1', typ:'$type'" 
	if [[ $type == video* ]]; then
		sub-cli.sh "$1" | $log
	fi
}

$log "Torrent dir:'$tdir', name:'$tname'"

if [ ! -d "$tdir" ]; then
	$log "Empty TR_TORRENT_DIR"
	exit 0
fi


if [ -d "$tfile" ]; then

	find "$tfile" -type f | while read i
	do
		download_subtitles "$i"
	done
else
	download_subtitles "$tfile"
fi
