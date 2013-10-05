#!/bin/bash

rootDir=$(cd "$(dirname "$0")/.."; pwd)
. $rootDir/utility.sh

declare -a FLAG_ARR

function flagInit (){
    for (( i = 0; i < 24; i++ )); do
        FLAG_ARR[i]=1                   #1:unkept #0:kept
    done
}

function timeKeeping (){
    #init
    MINUTE=`date +%M`
    HOUR=`date +%H`
    TMP=''

    #when occur at XX:01 XX:59 XX:00
    if [[ $MINUTE -eq 1 ]] || [[ $MINUTE -eq 59 ]] || [[ $MINUTE -eq 0 ]]; then
        # last hour , so need add one clock
        if [[ $MINUTE -eq 59 ]]; then
            TMP=$(echo $HOUR+1 | bc)
        else
            TMP=$HOUR
        fi

        #when occur at 23:59 the 24 is wrong ,the right is 0
        if [[ $TMP -eq 24 ]]; then
            TMP=0
        fi

        #when run as deamon , if has be reported then do nothing
        if [[ ${FLAG_ARR[$TMP]} -eq 1 ]]; then
            speak "Now, "$TMP$" o'clock"
            FLAG_ARR[$TMP]=0
        fi

        #if 0 a new day , so re-init
        if [[ $TMP -eq 0 ]]; then
            speak "Now, "$TMP$" o'clock. A new day!"
            flagInit
        fi
    fi
}

function timeKeeping_deamon (){
    while [[ true ]]; do
    
        timeKeeping

        sleep 60

    done    
}

#init flag for run as deamon
flagInit


if [[ $# -eq 0 ]]; then
    timeKeeping
    exit 0
fi

while getopts ":d" optname
do
    case "$optname" in
    "d")
        echo "timeKeeping_deamon"
        timeKeeping_deamon
    ;;
    *)
        echo "others"
    ;;
    esac
done



    



