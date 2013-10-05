var url  =require('url');

function route (handle, request, response) {
    var pathName = url.parse(request.url).pathname;
    console.log("request for" + pathName + " received");

    if (typeof handle[pathName] === "function") {
        return handle[pathName](request, response);
    } else {
        console.log("No request handler found for" + pathName);
        response.writeHead(404,{'Content-Type' : 'text/plain'});
        response.write("404 Not found");
        response.end();
    }

}

exports.route = route;