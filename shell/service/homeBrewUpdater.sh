#!/bin/bash

#block until network is connected!
ONLINE=`blockedNetworkCheck | awk '{print $1}'`

if [ $# -eq 0 ]; then
    speak "home brew updater started!"

    if [ $ONLINE -eq 0 ]; then
        brew update
        sleep 30
        brew upgrade
    fi
fi

    