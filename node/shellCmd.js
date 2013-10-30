
var fs           = require("fs");
var path         = require("path");
var nodeDirPath  = __dirname;
var shellDirPath = path.normalize(nodeDirPath+"/../shell");


function getShellCmdList () {
    var shellCmdList={
        "sayhello"          : "sh " + shellDirPath + "/service/sayhello.sh",
        "proxy_on"          : "sh " + shellDirPath + "/service/proxy.sh",
        "proxy_off"         : "say -v alex closing proyx & killall -HUP python",
        "closeServer"       : "say -v alex closing server & killall -HUP node",
        "weather"           : "python " + shellDirPath + "/service/weather.py",
        "memoryMonitor"     : "sh " + shellDirPath + "/service/memoryMonitor.sh",
        "cpuMonitor"        : "sh " + shellDirPath + "/service/cpuMonitor.sh",
        "timekeeping"       : "sh " + shellDirPath + "/service/timeKeeping.sh",
        "network"           : "sh " + shellDirPath + "/service/network.sh",
        "battery"           : "sh " + shellDirPath + "/service/battery.sh",
        "trashClear"        : "sh " + shellDirPath + "/service/trashClear.sh",
        "homeBrewUpdater"   : "sh " + shellDirPath + "/service/homeBrewUpdater.sh",
        "nbaForecast"       : "sh " + shellDirPath + "/service/nbaForecast.sh"
    };

    return shellCmdList;
}



exports.getShellCmdList=getShellCmdList;