//modules 
var http =require('http');

function start (route, handle) {
    function onRequest(request, response){
        route(handle, request, response);
    }

    http.createServer(onRequest).listen(9876);
    console.log("server has started");
}

exports.start=start;

