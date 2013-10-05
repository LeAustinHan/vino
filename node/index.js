#!/usr/local/bin/node

var server               = require("./deamonServer");
var router               = require("./router");
var requestHandlers      = require("./requestHandlers");

var handle               = {}
handle["/"]              = requestHandlers.root;
handle["/sayhello"]      = requestHandlers.sayhello;
handle["/helloworld"]    = requestHandlers.helloworld;
handle["/ls"]            = requestHandlers.ls;
handle["/proxy_on"]      = requestHandlers.proxy_on;
handle["/proxy_off"]     = requestHandlers.proxy_off;
handle["/closeServer"]   = requestHandlers.closeServer;
handle["/weather"]       = requestHandlers.weather;
handle["/memoryMonitor"] = requestHandlers.memoryMonitor;
handle["/cpuMonitor"]    = requestHandlers.cpuMonitor;
handle["/timekeeping"]   = requestHandlers.timekeeping;
handle["/network"]  = requestHandlers.network;
handle["/battery"]       = requestHandlers.battery;
handle["/trashClear"]    = requestHandlers.trashClear;

server.start(router.route, handle);