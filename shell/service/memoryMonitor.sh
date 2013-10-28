#!/bin/bash

rootDir=$(cd "$(dirname "$0")/.."; pwd)
. $rootDir/utility.sh

WARNNING_PERCENT=0.80
MEM_OVER="1"

function monitor (){
    ALL_MEM_INFO=$(top -l 1 | grep PhysMem: | awk '{print $0}')    
    USED_M=$(echo "$ALL_MEM_INFO" | awk '{print $2}' | cut -f 1 -d M)
    WIRED_M=$(echo "$ALL_MEM_INFO" | awk '{print $4}' | cut -f 2 -d \( | cut -f 1 -d M)
    FREE_M=$(echo "$ALL_MEM_INFO" | awk '{print $6}' | cut -f 1 -d M)

    TOTAL_USED=$((USED_M+WIRED_M))
    TOTAL_M=$((TOTAL_USED+FREE_M))

    USED_PERCENT=`echo "scale=2;$TOTAL_USED/$TOTAL_M" | bc`

    MEM_FLAG=$(echo "$USED_PERCENT >= $WARNNING_PERCENT" | bc)
    
    if [[ $MEM_FLAG = $MEM_OVER ]]; then
        speak "memory warnning! Now, clearing memory..."
        purge
        speak "memory cleared"
    fi
}

function monitor_deamon (){
    while [ true ]; do
        
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
