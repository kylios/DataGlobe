part of data_globe;

class DataGlobe {

    JsGlobe _globe;
    Map<String, dynamic> _dataOpts = new Map<String, dynamic>();
    Provider _provider = null;
    bool _received = false;

    DataGlobe(var container) {

        this._globe = new JsGlobe(container);
    }

    set dataOpts(Map<String, dynamic> dataOpts) => this._dataOpts = dataOpts;
    Map<String, dynamic> get dataOpts => this._dataOpts;

    set provider(Provider provider) {

        this._provider = provider;
        this._provider.listen(this._onData);
    }
    Provider get provider => this._provider;

    void _onInit([List<num> data = null]) {
        if (data == null) {
            data = [];
        }
        this._globe.addData(data, this._dataOpts);
        this._globe.createPoints();
        this._globe.animate();
    }

    void _onData(List<num> data) {
        if (! this._received) {
            this._onInit(data);
            this._received = true;
        } else {
            this._globe.addData(data, this._dataOpts);
            this._globe.createPoints();
        }
    }
}
