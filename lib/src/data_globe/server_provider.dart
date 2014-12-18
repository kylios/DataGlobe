part of data_globe;

class ServerProvider extends Provider {


    String _host;
    int _port;
    String _path;
    WebSocket _ws;

    ServerProvider(this._host, [this._port = 80, this._path = '']) {

        this._ws = new WebSocket(this.url);

        this._connect();
    }

    String get url => 'ws:${this._host}:${this._port}/${this._path}';

    void _connect() {
        this._ws.onOpen.first.then((_) {
              onConnected();
              this._ws.onClose.first.then((_) {
                onDisconnected();
              });
            this._ws.onError.first.then((_) {/*...*/});
        });
    }

    void onConnected() {
        this._ws.onMessage.listen((e) {
              this._handleMessage(e.data);
            });
    }
    void onDisconnected() {
        print("Connection disconnected to ${this._ws.url}");
    }


    void _handleMessage(var json) {
        List<List<dynamic>> data = JSON.decode(json);
        print("Got data: ");
        print(data);

        this.sendData(data[0][1]);
    }
}