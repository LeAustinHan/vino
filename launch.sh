#!/bin/bash


CONST_SERVER_PROCESS_NAME="node"

while true; do
    
    SERVER_PROCESS_NAME=$(lsof -i:9876 | awk '/1/ {print $1}')

    if [ $SERVER_PROCESS_NAME ]; then
        if [ $SERVER_PROCESS_NAME = $CONST_SERVER_PROCESS_NAME ]; then
            break
        fi
    fi

    echo waiting server starting....
    sleep 10 #sleep a minute

done

curl http://localhost:9876/sayHello

sleep 10
curl http://localhost:9876/proxy_on

sleep 10
curl http://localhost:9876/weather

sleep 10
curl http://localhost:9876/memoryMonitor?opt=d          #opt:d run as deamon

sleep 10
curl http://localhost:9876/cpuMonitor?opt=d             #opt:d run as deamon

sleep 10
curl http://localhost:9876/timekeeping?opt=d            #opt:d run as deamon

sleep 10
curl http://localhost:9876/checkNetwork?opt=d           #opt:d run as deamon

sleep 10
curl http://localhost:9876/battery?opt=d                #opt:d run as deamon

sleep 10
curl http://localhost:9876/trashClear?opt=d             #opt:d run as deamon

sleep 10
curl http://localhost:9876/nbaForecast

sleep 10
curl http://localhost:9876/homeBrewUpdater



