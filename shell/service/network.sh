#!/bin/bash

rootDir=$(cd "$(dirname "$0")/.."; pwd)
. $rootDir/utility.sh


function checkNetwork() {
    ONLINE=`networkCheck | awk '{print $1}'`

    if [ $ONLINE -eq 1 ]; then
        speak "disconnect network"
    fi
}

function checkNetwork_deamon() {
    while [ true ]; do
        
        checkNetwork

        sleep 60

    done
}


if [ $# -eq 0 ]; then
    
    checkNetwork

    exit 0
fi

while getopts ":d" optname
do
    case "$optname" in
    "d")
        echo "checkNetwork_deamon"
        checkNetwork_deamon
    ;;
    *)
        echo "others"
    ;;
    esac
done