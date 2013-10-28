#!/bin/bash
#-*- utf-8 -*-

rootDir=$(cd "$(dirname "$0")/.."; pwd)
. $rootDir/utility.sh

#block until network is connected!
blockedNetworkCheck

if [[ $# -eq 0 ]]; then
    speak "home brew updater started!"

    eval `which brew`" ""update" && sleep 30 && eval `which brew`" ""upgrade"
    
fi

    