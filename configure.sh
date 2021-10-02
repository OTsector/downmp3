#!/bin/bash

if [ $UID -ne 0 ]; then
	echo "ERROR: need to run as root"
	exit 1
fi

if ! [ -f /usr/bin/python ]; then
	apt-get install python -y &> /dev/null
fi
if ! [ -f /usr/bin/wget ]; then
	apt-get install wget -y &> /dev/null
fi
if ! [ -f /usr/bin/ffplay ]; then
	apt-get install ffmpeg -y &> /dev/null
fi
if ! [ -f /usr/local/bin/youtube-dl ]; then
	curl -s -L -A '' https://yt-dl.org/downloads/latest/youtube-dl \
		-o /usr/local/bin/youtube-dl && echo "youtube-dl has been installed"
	chmod a+rx /usr/local/bin/youtube-dl
fi
wget https://raw.githubusercontent.com/OTsector/downmp3/master/downmp3.sh \
	-O /usr/bin/downmp3 \
		&& chmod +x /usr/bin/downmp3 \
	&& wget https://raw.githubusercontent.com/OTsector/downmp3/master/playsong.sh \
		-O /usr/bin/playsong \
			&& chmod +x /usr/bin/playsong

[ $? -eq 0 ] && { echo "INFO: well done!"; }
