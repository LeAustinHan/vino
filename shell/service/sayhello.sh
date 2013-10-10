#!/bin/bash

rootDir=$(cd "$(dirname "$0")/.."; pwd)
. $rootDir/utility.sh

HOUR=`date +%H`
TMP=''

if [ $HOUR -lt 12 ]; then
    TMP="Good morning"

elif [ $HOUR -gt 18 ]; then
    TMP="Good evening"

else 
    TMP="Good afternoon"
fi

HELLO_WORDS=$TMP$" boss"
speak "$HELLO_WORDS"