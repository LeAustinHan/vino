#!/bin/bash

rootDir=$(cd "$(dirname "$0")/.."; pwd)
. $rootDir/utility.sh

BASE_ATTACHMENT_PATH="/usr/local/vino/attachment"
GOAGENT_PATH=$BASE_ATTACHMENT_PATH/goAgent_3.0.4/local/proxy.py

networkForProxy_on(){
    networksetup -setwebproxystate 'Wi-Fi' on
    networksetup -setsecurewebproxystate 'Wi-Fi' on
}


networkForProxy_off(){
    networksetup -setwebproxystate 'Wi-Fi' off
    networksetup -setsecurewebproxystate 'Wi-Fi' off
}


proxy_on(){
    echoWithSpeaking "opening go agent proxy..."
    python $GOAGENT_PATH
}

proxy_on