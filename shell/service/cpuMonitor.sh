#!/bin/bash

rootDir=$(cd "$(dirname "$0")/.."; pwd)
. $rootDir/utility.sh

WARNNING_PERCENT=40
CPU_OVER="1"

function monitor (){
    ALL_CPU_INFO=$(top -l 5 | grep 'CPU usage' | awk '{print $0}') 
    IDEL_C=$(echo "$ALL_CPU_INFO" | awk '{print $7}' | cut -f 1 -d %)

    #all 5 sample
    IDEL_C_1=$(echo $IDEL_C | cut -f 1 -d" " )
    IDEL_C_2=$(echo $IDEL_C | cut -f 2 -d" " )
    IDEL_C_3=$(echo $IDEL_C | cut -f 3 -d" " )
    IDEL_C_4=$(echo $IDEL_C | cut -f 4 -d" " )
    IDEL_C_5=$(echo $IDEL_C | cut -f 5 -d" " )

    IDEL_C_TOTAL=`echo $IDEL_C_1+$IDEL_C_2+$IDEL_C_3+$IDEL_C_4+$IDEL_C_5 | bc`
    IDEL_C_AVG=`echo $IDEL_C_TOTAL/5 | bc`

    echo $IDEL_C_AVG

    CPU_FLAG=$(echo "$IDEL_C_AVG <= $WARNNING_PERCENT" | bc)
    echo $CPU_FLAG

    if [[ $CPU_FLAG = $CPU_OVER ]]; then
        speak "c p u warnning!"
        speak "now idel is "
        speak $IDEL_C_AVG"%"
        speak "please look more detail with activity monitor!"
    fi
}

function monitor_deamon (){
    while [[ true ]]; do
        
        monitor

        sleep 60

    done
}


if [[ $# -eq 0 ]]; then
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
