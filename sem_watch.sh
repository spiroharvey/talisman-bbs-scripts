#!/bin/bash

. ${0%/*}/inc.bbsConfig

logFile="$_bbsLogDir/sem_watch.log"
cd $bbsBaseDir

inotifywait -qme modify *.sem |
	while read event; do
		bbsLogEvent $event >> $logFile
		bbsLogEvent "./postie scan" >> $logFile
		./postie scan
	done


