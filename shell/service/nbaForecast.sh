#!/bin/bash
# -*- utf-8 -*-

rootDir=$(cd "$(dirname "$0")/.."; pwd)
targetDir=$(cd "$(dirname "$0")/../../attachment"; pwd)

. $rootDir/utility.sh

#because of time difference, in Beijing, 'today' is 'yestoday' in usa
YEAR=`date -j -v -1d | awk '{print $6}'`
MONTH=`date -j -v -1d | awk '{print $2}'`
DAY=`date -j -v -1d | awk '{print $3}'`

HANDLING_LINE=''

MATCHING_TEAM='L.A. Lakers'             #focus Los angel's Lakers

#if true open on live web site
OPEN_WEBSITE=true


function openOnLiveWebSite (){
# exec osascript <<EOF
osascript -e '
    tell application "Safari"
      activate
      -- close all but one tab of the front window
      try
        repeat
          close tab 2 of window 1
        end repeat
      end try
      -- open the URLs in separate tabs
      tell window 1
        set URL of tab 1 to "http://nba.hupu.com/tv"
        # make new tab with properties {URL:"http://localhost:8081"}
      end tell
    end tell'
}

function matchTeam () {
    FIELD_NUM=`echo $HANDLING_LINE | awk '{print NF}'`

    TEAM_AWAY=''
    TEAM_HOME=''
    TIME=''

    if [[ $FIELD_NUM -eq 10 ]]; then
        TEAM_AWAY=`echo $HANDLING_LINE | awk '{print $5}'`
        TEAM_HOME=`echo $HANDLING_LINE | awk '{print $6}'`
        TIME=`echo $HANDLING_LINE | awk '{print $9}'`
    fi

    if [[ $FIELD_NUM -eq 11 ]]; then

        TEAM_AWAY=`echo $HANDLING_LINE | awk '{
                                                tmp_team_1=$5" "$6
                                                if(tmp_team_1=="L.A. Clippers"  || tmp_team_1=="L.A. Lakers"    ||
                                                    tmp_team_1=="New Orleans"   || tmp_team_1=="Oklahoma City"  ||
                                                    tmp_team_1=="Golden State"  || tmp_team_1=="New York"       ||
                                                    tmp_team_1=="San Antonio"    ){
                                                    print tmp_team_1
                                                }else{
                                                    print $5
                                                }
                                               }'`

        TEAM_HOME=`echo $HANDLING_LINE | awk '{
                                                tmp_team_1=$6" "$7
                                                if(tmp_team_1=="L.A. Clippers"  || tmp_team_1=="L.A. Lakers"    ||
                                                    tmp_team_1=="New Orleans"   || tmp_team_1=="Oklahoma City"  ||
                                                    tmp_team_1=="Golden State"  || tmp_team_1=="New York"       ||
                                                    tmp_team_1=="San Antonio"    ){
                                                    print tmp_team_1
                                                }else{
                                                    print $7
                                                }
                                               }'`
        TIME=`echo $HANDLING_LINE | awk '{print $10}'`
    fi

    if [[ $FIELD_NUM -eq 12 ]]; then
        TEAM_AWAY=`echo $HANDLING_LINE | awk '{print $5" "$6}'`
        TEAM_HOME=`echo $HANDLING_LINE | awk '{print $7" "$8}'`
        TIME=`echo $HANDLING_LINE | awk '{print $11}'`
    fi

    #handle time split with ':'
    TIME_HOUR=`echo $TIME | cut -f 1 -d: `
    TIME_MINUTE=`echo $TIME | cut -f 2 -d: `

    #beijing and american est zone diff is 13 hours
    TIME_HOUR=`echo 13-12+$TIME_HOUR| bc`

    HAS_MATCHED=false
    #matching team is away
    if [[ $TEAM_AWAY = $MATCHING_TEAM ]]; then
        HAS_MATCHED=true
        speak "NBA forecast: today!"
        speak "$TEAM_AWAY"
        speak " VS "
        speak "$TEAM_HOME"
        speak "$MATCHING_TEAM"$" is away team!"
        speak "Time is :"
        speak "$TIME_HOUR"" ""$TIME_MINUTE"" AM"
    fi

    #matching team is home
    if [[ $TEAM_HOME = $MATCHING_TEAM ]]; then
        HAS_MATCHED=true
        speak "nba forecast: today!"
        speak "$TEAM_AWAY"
        speak " VS "
        speak "$TEAM_HOME"
        speak "$MATCHING_TEAM"$" is home team!"
        speak "Time is :"
        speak "$TIME_HOUR"" ""$TIME_MINUTE"" AM"
    fi

    #if open the on live web site
    if [[ OPEN_WEBSITE ]] && [[ HAS_MATCHED ]]; then
        openOnLiveWebSite                               #open web site
    fi

}


function match () {
    FIELD_NUM=`echo $HANDLING_LINE | awk '{print NF}'`

    if [[ $FIELD_NUM -lt 7 ]]; then
        return 0
    fi

    TMP_YEAR=`echo $HANDLING_LINE | awk '{print $4}'`
    TMP_MONTH=`echo $HANDLING_LINE | awk '{print $2}'`
    TMP_MONTH=`echo ${TMP_MONTH:0:3}`
    TMP_DAY=`echo $HANDLING_LINE | awk '{print $3}' | cut -f 1 -d ,`

    if [[ $YEAR = $TMP_YEAR ]]; then            #match year
        if [[ $MONTH = $TMP_MONTH ]]; then      #match month
            if [[ $DAY -eq $TMP_DAY ]]; then      #match day
                matchTeam $HANDLING_LINE
            fi
        fi
    fi

}


while read line
do
    # echo $line | awk '{ print $1 $2}'
    # echo $line
    HANDLING_LINE=$line
    match

done < $targetDir/nba_2013_to_2014_schedule.md