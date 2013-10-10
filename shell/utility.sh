#!/bin/bash

SPEAKSWITCH=true

function echoWithSpeaking (){
    echo $1

    if isMacOSX ; then
        if "$SPEAKSWITCH" ; then
            say -v alex $1
        fi
    fi
}

function speak (){
    if isMacOSX ; then
        if [ "$SPEAKSWITCH" = true ]; then
            say -v alex $1
        fi
    fi
}

function isMacOSX (){
   SYSTEM=`uname -s`

   if [ $SYSTEM != "Darwin" ] ; then 
       retrn 1
   fi

   return 0
}

function openSpeakSwitch (){
    SPEAKSWITCH=true
}

function closeSpeakSwitch (){
    SPEAKSWITCH=false
}

function networkCheck () {
    PINGRET=$( ping -c 4 8.8.8.8  | grep "ttl=" )
 
    [ -z "$PINGRET" ] &&
    {
        PINGRET=$( ping -c 4 8.8.4.4  | grep "ttl=" )
     
        [ -z "$PINGRET"  ] &&
        {
            echo 1
        }
    }||
    {
        echo 0
    }
}

function blockedNetworkCheck() {
    while [[ true ]]; do
        PINGRET=$( ping -c 4 8.8.8.8  | grep "ttl=" )
 
        [ -z "$PINGRET" ] &&
        {
            PINGRET=$( ping -c 4 8.8.4.4  | grep "ttl=" )
         
            [ -z "$PINGRET"  ] &&
            {
                sleep 60
            }
        }||
        {
            echo 0
            break                   #exit
        }
    done
}
