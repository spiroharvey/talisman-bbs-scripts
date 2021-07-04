#!/bin/bash

. ${0%/*}/inc.bbsConfig

logFile="$_bbsLogDir/sem_watch.log"
cd $bbsBaseDir

inotifywait -qme modify -o $logFile *.sem |
	while read event; do
		bbsLogEvent "./postie scan" >> $logFile
		./postie scan
	done


