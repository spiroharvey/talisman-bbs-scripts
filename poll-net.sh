#!/bin/bash

# poll-net.sh
# by Spiro Harvey <spiro.harvey@protonmail.com>
# 04 July 2021

# binkd/FTN polling script
# usage: ./poll-net.sh <netname>

# This script looks in your binkd config for your configured nodes
# if it finds a match, it will poll that node

if [ -z $1 ]; then
	echo "Please supply netname"
	echo "Usage $0 <netname>"
	echo "    eg; $0 fsxnet"
	exit 1
fi

. ${0%/*}/inc.bbsConfig
binkdConfig="$_bbsBaseDir/$_bbsEtcDir/binkd.conf"
pollNet="$1"

binkpoll() {
	if [ -z $1 ]; then
		echo "failed to pass parameter to binkpoll()"
		exit 1
	fi

	echo "[*] Polling node: $1"
	binkd -p -P $1 $binkdConfig
}

while IFS= read -r line; do
	if [ "$(echo $line | cut -d' ' -f1)" = "node" ]; then
		nets+=($(echo $line | cut -d' ' -f2))
	fi
done < $binkdConfig

for net in ${nets[@]}; do 
	if [ "${net#*@}" = "$pollNet" ]; then
		binkpoll $net
	fi
done


