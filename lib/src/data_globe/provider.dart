part of data_globe;

abstract class Provider {

    StreamController<List<num>> _stream = new StreamController<List<num>>();

    List<DataGlobe> _subscribers = new List<DataGlobe>();

    void subscribe(DataGlobe globe) {
        this._subscribers.add(globe);
    }


    void listen(var fn) {
        this._stream.stream.listen(fn);
    }
    void sendData(List<num> data) {
        this._stream.add(data);
    }

    // onAdd
    // onReset
    //
}