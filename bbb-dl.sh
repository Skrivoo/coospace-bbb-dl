#!/bin/bash
case $1 in
		"-h")
		echo "Syntax: script.sh -i [bemeneti link] -o [eloadas neve]."
		echo "A script jelenlegi formaban csak a kepernyomegosztast menti le, webkamera kepet nem. A kapcsolok felcserelhetoek. v1.0"
		exit
		;;
		"-i")
		LINK=$2
		;;
		"-o")
		OUTPUT=$2
		;;
esac
case $3 in
		"-i")
		LINK=$4
		;;
		"-o")
		OUTPUT=$4
		;;
esac
BAS=$(echo $LINK | sed 's/playback\/presentation\/2.0\/playback.html?meetingId=/presentation\//') #a modositott eleresi ut alapja
WEBCAM="${BAS}/video/webcams.webm" #teljes eleresi ut a "webcam"-hoz, altalaban ezen van a hang.
DESKSHARE="${BAS}/deskshare/deskshare.webm" #ez pedig a kepernyomegosztas
wget $WEBCAM -q -c --show-progress -t 0 -T 5 -o webcams.webm #a video letoltese
wget $DESKSHARE -q -c --show-progress -t 0 -T 5 -o deskshare.webm
mkvextract webcams.webm tracks 1:hang.ogg # a hang kinyerese
mkvextract deskshare.webm tracks 0:kepernyomegosztas.vp9 # video anyag kinyerese
mkvmerge -o "$OUTPUT.mkv" --language 0:hun kepernyomegosztas.vp9 --language 0:hun hang.ogg # 
echo "Felesleges fajlok torlese..."
rm webcams.webm
rm deskshare.webm
rm hang.ogg
rm kepernyomegosztas.vp9