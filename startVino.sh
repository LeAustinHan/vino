#!/bin/bash
# -*- utf-8 -*-

baseDirForScriptSelf=$(cd "$(dirname "$0")"; pwd)
LogDirPath=$(cd "$(dirname "$0")/log/"; pwd)
VinoPath=$baseDirForScriptSelf/node/index.js

YEAR=`date +%Y`
MONTH=`date +%m`
DAY=`date +%d`
HOUR=`date +%H`
MINUTE=`date +%M`

#file name
FILENAME=$YEAR"_"$MONTH"_"$DAY"_"$HOUR"_"$MINUTE".log"

#create file
touch $LogDirPath/$FILENAME

#std_out redirect to a log file
node $VinoPath > $LogDirPath/$FILENAME