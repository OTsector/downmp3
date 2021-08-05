#!/bin/bash
#		 _
#	07	[|] 0ffensive 7ester
#
# GLP v3.0 by -07: https://github.com/OTsector

function ascii2url {
	local text="$*"
	local out=
	for((i=0; i<${#text}; i++)); do
		c=${text:$i:1}
		case $c in
			[a-zA-Z0-9.~_-]) out+="$c" ;;
			*) out+=`printf '%%%02X' "'$c"` ;;
		esac
	done
	echo $out
}

if [ $# -lt 2 ]; then
	echo "use: "$0" [name of song] [directory]"; exit 1
fi
name=$1
dir=$2
if ! [ -d $dir ]; then
	echo "ERROR: directory \""$dir"\" isn't exsist"; exit 1
fi

urlName=`ascii2url $name`
link="https://www.youtube.com/watch?v="$(
	curl -sLgk 'https://www.youtube.com/results?search_query='"$urlName" \
		-H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0.1) Gecko/20100101 Firefox/76.0.1' \
		-H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' \
		-H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Connection: keep-alive' \
		-H 'Upgrade-Insecure-Requests: 1' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'TE: Trailers' \
			|tr -d "\n" \
			|sed 's/,"commandMetadata":{"webCommandMetadata":{"url":"/\n,"commandMetadata":{"webCommandMetadata":{"url":"/g' \
			|grep ',"commandMetadata":{"webCommandMetadata":{"url":"'|grep 'title":{"runs":\[{"text":"' \
			|sed 's/"videoIds":\["/\n"videoIds":\["/g'|grep '"videoIds"'|awk -F '"' '{print $4}'|head -n 1
)
if [[ ${link#*\?} != "" ]]; then
	youtube-dl --extract-audio --audio-format mp3 $link -o $dir"/$name.%(ext)s"# \
#		&> /dev/null
	if [ $? -eq 0 ];then
		echo "\"$name"\" file downloaded in directory \"$dir"\""
	else
		echo "ERROR: while downloading"; exit 1
	fi
else
	echo "ERROR: connection problem"; exit 1
fi

exit 0
