#!/bin/bash

. ${0%/*}/inc.bbsConfig

logFile="$_bbsLogDir/file_watch.log"
stickCmd="./stick -c $_bbsEtcDir/stick.cfg"

cd $_bbsBaseDir

inotifywait -qme create ftn/inbound/ |
	while read event; do
		bbsLogEvent "$event" >> $logFile
		if [[ $event == *"tic" ]]; then
			bbsLogEvent "$stickCmd" >> $logFile
			$stickCmd
		fi
	done


