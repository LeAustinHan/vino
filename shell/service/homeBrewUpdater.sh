#!/bin/bash

#block until network is connected!
blockedNetworkCheck

if [ $# -eq 0 ]; then
    speak "home brew updater started!"

    brew update
    sleep 30
    brew upgrade
fi

    