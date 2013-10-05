
var exec         = require("child_process").exec;
var shellCmdList = require("./shellCmd").getShellCmdList();
var url          = require('url');
var queryString  = require("querystring");

function root (request, response){
    console.log("hello world");
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.write("/");
    response.end();
}


function sayhello (request, response){
    exec(shellCmdList["sayhello"], function(error, stdout, stderr){
        logExecInfo("sayhello", error, stdout, stderr);
    })

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end();

}


function helloworld (request, response) {

    exec("say -v Alex helloworld", function (error, stdout, stderr){
        
    })

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end();

}


function ls (request, response) {

    exec("ls -lah", function (error, stdout, stderr){
        response.writeHead(200, {"Content-Type": "text/plain"});
        response.write("output");
        response.write("");
        response.write(stdout);
        response.write("");
        response.write("error:\n");
        response.write(stderr);
        response.end();
    })

}


function proxy_on (request, response) {

    exec(shellCmdList["proxy_on"], function(error, stdout, stderr){
        logExecInfo("proxy_on", error, stdout, stderr);
    })

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end();
}


function proxy_off (request, response) {

    exec(shellCmdList["proxy_off"], function(error, stdout, stderr){
        logExecInfo("proxy_off", error, stdout, stderr);
    })

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end();
}


function closeServer (request, response) {
    exec(shellCmdList["closeServer"], function(error, stdout, stderr){
        logExecInfo("closeServer", error, stdout, stderr);
    })

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end();
}


function weather (request, response) {
    exec(shellCmdList["weather"], function(error, stdout, stderr){
        logExecInfo("weather", error, stdout, stderr);
    })

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end();
}

function memoryMonitor (request, response) {

    var paramObj=queryString.parse(url.parse(request.url).query);
    var cmd=shellCmdList["memoryMonitor"];

    if (typeof paramObj !="undefined" 
        && 
        typeof paramObj.opt != "undefined" 
        && 
        paramObj.opt=="d") {
        cmd+=" -d";
    };

    exec(cmd, function(error, stdout, stderr){
        logExecInfo("memoryMonitor", error, stdout, stderr);
    })

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end();
}

function cpuMonitor (request, response) {
    var paramObj=queryString.parse(url.parse(request.url).query);
    var cmd=shellCmdList["cpuMonitor"];

    if (typeof paramObj !="undefined" 
        && 
        typeof paramObj.opt != "undefined" 
        && 
        paramObj.opt=="d") {
        cmd+=" -d";
    };

    exec(cmd, function(error, stdout, stderr){
        logExecInfo("cpuMonitor", error, stdout, stderr);
    })

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end();
}

function timekeeping (request, response) {
    var paramObj=queryString.parse(url.parse(request.url).query);
    var cmd=shellCmdList["timekeeping"];

    if (typeof paramObj !="undefined" 
        && 
        typeof paramObj.opt != "undefined" 
        && 
        paramObj.opt=="d") {
        cmd+=" -d";
    };

    exec(cmd, function(error, stdout, stderr){
        logExecInfo("timekeeping", error, stdout, stderr);
    })

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end();
}

function network (request, response) {
    var paramObj=queryString.parse(url.parse(request.url).query);
    var cmd=shellCmdList["network"];

    if (typeof paramObj !="undefined" 
        && 
        typeof paramObj.opt != "undefined" 
        && 
        paramObj.opt=="d") {
        cmd+=" -d";
    };

    exec(cmd, function(error, stdout, stderr){
        logExecInfo("network", error, stdout, stderr);
    })

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end();
}

function battery (request, response){
    var paramObj=queryString.parse(url.parse(request.url).query);
    var cmd=shellCmdList["battery"];

    if (typeof paramObj !="undefined" 
        && 
        typeof paramObj.opt != "undefined" 
        && 
        paramObj.opt=="d") {
        cmd+=" -d";
    };

    exec(cmd, function(error, stdout, stderr){
        logExecInfo("battery", error, stdout, stderr);
    })

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end();
}

function trashClear (request, response) {
    var paramObj=queryString.parse(url.parse(request.url).query);
    var cmd=shellCmdList["trashClear"];

    if (typeof paramObj !="undefined" 
        && 
        typeof paramObj.opt != "undefined" 
        && 
        paramObj.opt=="d") {
        cmd+=" -d";
    };

    exec(cmd, function(error, stdout, stderr){
        logExecInfo("trashClear", error, stdout, stderr);
    })

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end();
}



/**
 * helper: log exec command info
 * @param {string} funcName function name
 * @param  {object} err    error object
 * @param  {string} stdout standard output
 * @param  {string} stderr standard error
 * @return {null}        
 */
function logExecInfo (funcName, err, stdout, stderr) {
    console.log("/*******************" + funcName + "*******************/");
    if (err!=null) {
        console.log("error:"+err);
    };

    if (stdout!=null && stdout!="") {
        console.log("stdout:"+stdout);
    };

    if (stderr!=null && stderr!="") {
        console.log("stderr:"+stderr);
    };
}


exports.root          = root; 
exports.sayhello      = sayhello;
exports.helloworld    = helloworld;
exports.ls            = ls;
exports.proxy_on      = proxy_on;
exports.proxy_off     = proxy_off;
exports.closeServer   = closeServer;
exports.weather       = weather;
exports.memoryMonitor = memoryMonitor;
exports.cpuMonitor    = cpuMonitor;
exports.timekeeping   = timekeeping;
exports.network       = network;
exports.battery       = battery;
exports.trashClear    = trashClear;