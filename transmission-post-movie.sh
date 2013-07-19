#!/bin/bash

#
# Download movie subtitles from napiprojekt.pl after torrent finished
#

tdir=$TR_TORRENT_DIR

if [ ! -d $tdir ]; then
	echo "Empty TR_TORRENT_DIR"
	exit 0
fi

for i in `find $tdir -type f`; do
	type=`file -bi "$i"`
	if [[ $type == video* ]]; then
		 sub-cli.sh "$i"
	fi
done
