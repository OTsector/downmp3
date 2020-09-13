#!/bin/bash
#        _
#  07   [|] 0ffensive 7ester
#
# 	0 |) 1 |\|    https://github.com/OdinF13
#
# license: GLP v3.0

if [ $UID -eq 0 ]; then
	echo "ERROR: need to run as root"
	exit 1
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
if ! [ -f /usr/bin/downmp3 ]; then
			( wget https://raw.githubusercontent.com/OTsector/downmp3/master/downmp3.sh \
				-O /usr/bin/downmp3 \
					&& chmod +x /usr/bin/downmp3
fi
