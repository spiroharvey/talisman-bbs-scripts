#!/bin/bash

. ${0%/*}/inc.bbsConfig

logFile="$_bbsLogDir/file_watch.log"
stickCmd="./stick -c $_bbsEtcDir/stick.cfg"

cd $_bbsBaseDir

inotifywait -qme create -o $logFile ftn/inbound/ |
	while read event; do
		if [ $(ls -1 ftn/inbound/*.tic >/dev/null) -eq 0 ]; then
			bbsLogEvent "$stickCmd" >> logFile
			$stickCmd
		fi
	done


