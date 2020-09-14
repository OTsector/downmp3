# downmp3
	root@PC:~# downmp3

	download mp3 by song name...

	use: /usr/bin/downmp3 [name of song] [directory location]
	example: /usr/bin/downmp3 "YTcracker - Antisec" ~/Desktop
	root@PC:~# playsong 
	use: /usr/bin/playsong [song name/song list/stdin]
	root@PC:~# playsong "YTcracker - Antisec"
	INFO: downloading "YTcracker - Antisec"
	INFO: playing "YTcracker - Antisec"
## how to install:
	sudo apt-get update
	sudo apt-get install curl -y
	curl -sLgkA '' 'https://raw.githubusercontent.com/OTsector/downmp3/master/configure.sh'|sudo bash
## One line command:
	sudo apt-get update && sudo apt-get install curl -y && curl -sLgkA '' 'https://raw.githubusercontent.com/OTsector/downmp3/master/configure.sh'|sudo bash
