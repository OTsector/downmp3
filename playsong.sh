#!/bin/bash
#        _
#  07   [|] 0ffensive 7ester
#
# 	0 |) 1 |\|    https://github.com/OdinF13
#
# license: GLP v3.0

ram="$(mktemp -p /dev/shm/)"
log=$HOME"/."$(sed 's/.*\///g' <<< $0)".log"
title="$1"
path="/tmp/"$(sed 's/.*\///g' <<< $0)
rm -rf $path; mkdir -p $path

if [ -t 0 ]; then
	if [ $# -ge 0 ] && [ ${#1} -lt 5 ]; then
		echo "use: "$0" [song name/song list/stdin]"; exit 1
	fi
	while [ "$#" -gt 0 ]; do
		echo $1 >> $ram; shift 1;
	done
else
	while IFS= read -r title; do
		echo "$title" >> $ram
	done
fi

function download {
	echo -e "INFO: downloading \"$title\""
	while true; do
		downmp3 "$title" $path &> /dev/null \
		&& break || sleep 5s
	done
}
function preDownload {
	echo -e "INFO: downloading \"$new\""
	while true; do
		downmp3 "$new" $path &> /dev/null \
		&& break || sleep 5s
	done
	echo -e "INFO: download finished for \"$new\""
}

lastLine=$(wc -l < $ram)
for((i=1; i<=$lastLine; i++)); do
	title="$(sed $i'q;d' $ram)"
	rm -rf "$path"/play.mp3
	if [ ! -f "$path""/""$title"".mp3" ]; then
		download "$title"
	fi
	echo -e "INFO: playing \"$title\""
	if [ $(($i+1)) -le $lastLine ]; then
		new="$(sed $(($i+1))'q;d' $ram)"
		preDownload "$new" &
	fi
	mv "$path""/""$title"".mp3" "$path""/play.mp3"
	ffplay -nodisp -autoexit "$path"/play.mp3 &> /dev/null \
	&& echo "$title" >> $log
done

exit 0
