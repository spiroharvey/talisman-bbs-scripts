#!/bin/bash
. ${0%/*}/inc.bbsConfig

logrotate -s $_bbsBaseDir/$_bbsEtcDir/logrotate.status $_bbsBaseDir/$_bbsEtcDir/bbs-logrotate.conf
