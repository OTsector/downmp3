#!/bin/bash
#		 _
#	07	[|] 0ffensive 7ester
#
# GLP v3.0 by -07: https://github.com/OTsector

function install {
	if [[ $1 == "curl" ]]; then
		apt install curl -y &> /dev/null && echo "curl has been installed"
	fi
	if [[ $1 == "youtube-dl" ]]; then
		curl -s -L -A '' https://yt-dl.org/downloads/latest/youtube-dl \
			-o /usr/local/bin/youtube-dl && echo "youtube-dl has been installed"
		chmod a+rx /usr/local/bin/youtube-dl
	fi
}

if [ $# -lt 2 ]; then
	echo -e "\ndownload mp3 by song name...\n"
	echo "use: "$0" [name of song] [directory location]"
	echo "example: "$0" \"YTcracker - Antisec\" ~/Desktop"
	exit 1
fi

if ! [ -f /usr/bin/curl ]; then
	echo "ERROR: curl is not installed on this machine"
	printf "do you whant to install curl? "; read a
	if [[ $a == "y" ]] || [[ $a == "Y" ]]; then
		if [ $UID -eq 0 ]; then
			install curl
		else
			echo "ERROR: run this tool with root permission"
		fi
	else
		echo "ERROR: can't process without curl"; exit 1
	fi
fi
if ! [ -f /usr/local/bin/youtube-dl ]; then
	echo "ERROR: youtube-dl is not installed on this machine"
	printf "do you whant to install youtube-dl? "; read a
	if [[ $a == "y" ]] || [[ $a == "Y" ]]; then
		if [ $UID -eq 0 ]; then
			install youtube-dl
		else
			echo "ERROR: run this tool with root permission"
		fi
	else
		echo "ERROR: can't process without youtube-dl"; exit 1
	fi

fi

name=$1
dir=$2

if ! [ -d $dir ]; then
	echo "ERROR: directory \""$dir"\" isn't exsist"; exit 1
fi

urlName=${name// /+}
link="https://www.youtube.com"$( \
	curl -s -A 'Mediapartners-Google' \
		'https://www.youtube.com/results?search_query='$urlName'&pbj=1' \
		|tr -d "\n"|sed 's/<a/\n<a/g'|grep 'watch?v=' \
		|awk -F '"' '{print $4}'|grep 'watch?v='|head -1 \
	)

if [[ ${link#*\?} != "" ]]; then
	youtube-dl --extract-audio --audio-format mp3 $link -o $dir"/$name.%(ext)s" \
		&> /dev/null
	if [ $? -eq 0 ];then
		echo "\"$name"\" file downloaded in directory \"$dir"\""
	else
		echo "ERROR: while downloading"; exit 1
	fi
else
	echo "ERROR: connection problem"; exit 1
fi

exit 0

