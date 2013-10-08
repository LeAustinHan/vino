#!/bin/bash

rootDir=$(cd "$(dirname "$0")/.."; pwd)
. $rootDir/utility.sh

WARNNING_PERCENT=0.80
MEM_OVER="1"

function monitor (){
    ALL_MEM_INFO=$(top -l 1 | grep PhysMem: | awk '{print $0}')    
    USED_M=$(echo "$ALL_MEM_INFO" | awk '{print $8}' | cut -f 1 -d M)
    FREE_M=$(echo "$ALL_MEM_INFO" | awk '{print $10}' | cut -f 1 -d M)
    TOTAL_M=$((USED_M+FREE_M))

    USED_PERCENT=`echo "scale=2;$USED_M/$TOTAL_M" | bc`

    MEM_FLAG=$(echo "$USED_PERCENT >= $WARNNING_PERCENT" | bc)
    
    if [[ $MEM_FLAG = $MEM_OVER ]]; then
        speak "memory warnning! Now, clearing memory..."
        purge
        speak "memory cleared"
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
