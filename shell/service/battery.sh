#!/bin/bash

rootDir=$(cd "$(dirname "$0")/.."; pwd)
. $rootDir/utility.sh

WARNING_PERCENT=20.0
WARNING_OVER="1"
CONNECTED=""
CONNECTED_TMP=""
POWER_PERCENT=""
POWER_FULL=98.0

function monitor (){
    CONNECTED=`system_profiler SPPowerDataType | grep Connected: | awk '{print $2}'`
    POWER_PERCENT=`ioreg -l | grep -i capacity | tr '\n' ' | ' | awk '{printf("%.2f", $10/$5 * 100)}'`

    WARNING_FLAG=$(echo "$POWER_PERCENT <= $WARNING_PERCENT" | bc)

    if [[ $WARNING_FLAG = $WARNING_OVER ]]; then
        speak 'Battery warning: Power down!!!'
    fi
}

function monitor_deamon (){
    while [ true ]; do

        monitor

        if [[ $CONNECTED != $CONNECTED_TMP ]]; then
            if [[ $CONNECTED = 'No' ]]; then
                speak "AC Power disconnected!"
            else
                speak "AC Power connected! "
                CHARGING_FLAG=$(echo "$POWER_PERCENT <= $POWER_FULL" | bc)

                #if battery is charging!
                if [ $CHARGING_FLAG = "1" ]; then
                    speak "Now, Battery is Charging!"
                fi
            fi

            CONNECTED_TMP=$CONNECTED
        fi

        sleep 60
    done
}


if [[ $# -eq 0 ]]; then
    speak "battery checking!"
    monitor
    exit 0
fi

while getopts ":d" optname
do
    case "$optname" in
    "d")
        echo "monitor_deamon"
        monitor_deamon
    ;;
    *)
        echo "others"
    ;;
    esac
done