part of server;

class Server {

    int _port;
    String _buildPath;
    VirtualDirectory _virDir;

    List<num> _data;
    int _dataIdx = 0;
    int _dataInc = 3;

    Server([this._port = 80, this._buildPath = '../web']) {

    }

    void start() {

        File f = new File('${this._buildPath}/hello.json');
        List<Future> waitOn = [
                                f.readAsString(encoding: UTF8),
                                HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, this._port)
                               ];
        Future.wait(waitOn, eagerError: true).then((List<dynamic> values) {
            List<List<dynamic>> arr = JSON.decode(values[0]);
            this._data = arr[0][1];
            var server = values[1];

            print("bound $server");
            //Router router = new Router(server);

            this._virDir = new VirtualDirectory(this._buildPath)
                ..jailRoot = false
                ..allowDirectoryListing = true
                ..directoryHandler = this._directoryHandler
                ;
            // ...
            //this._virDir.serve(router.defaultStream);
            // ...

            /*
            router.serve(urlPattern(r'^.+\.json$'))
              .transform(new RequestWebSocketTransformer())
              .listen(this._webSocketHandler);

               */
            server.listen((HttpRequest request) {

                Uri uri = request.uri;
                String filePath = uri.path;

                String connection = null;
                print(request.headers.value(HttpHeaders.CONNECTION));

                if (request.headers.value(HttpHeaders.CONNECTION).toLowerCase() != "upgrade") {
                    print("file exists");
                    this._virDir.serveRequest(request);
                } else {
                    print("Got a request $request, upgrading to websocket..");
                    WebSocketTransformer.upgrade(request)
                        .then((WebSocket webSocket) {
                            this._webSocketHandler(webSocket, request);
                        });
                }
            });
        });
    }

    void _directoryHandler(dir, request) {
        var indexUri = new Uri.file(dir.path).resolve('index.html');
        print("Serving ${indexUri}");
        this._virDir.serveFile(new File(indexUri.toFilePath()), request);
    }

    void _webSocketHandler(WebSocket webSocket, HttpRequest request) {

        print("Got a websocket $webSocket");

        webSocket.listen((json) {
            print("Got data from the client: $json");
        });

        Timer t = new Timer.periodic(new Duration(milliseconds: 50), (Timer t) {
            print("Timer");
            if (this._dataIdx + this._dataInc > 1 + this._data.length) {
                t.cancel();
            } else {
                List<num> vals = this._data.sublist(this._dataIdx, this._dataIdx + this._dataInc);
                this._dataIdx += this._dataInc;
                webSocket.add(JSON.encode([["test", vals]]));
            }
        });
    }

}
