part of js_globe;

class JsGlobe {

    var _globeConstructor = context['DAT']['Globe'];

    //JsObject _container = new JsObject(context['document']).callMethod('getElementById', ['globe_container']);
    JsObject _globe = null;
    JsObject _tween = null;

    JsGlobe(var container) {
        /*this._globe = context['Object'].callMethod('create', [_globeConstructor, new JsObject.jsify(
                {
                    "zoom": 8,
                    "mapTypeId": context['google']['maps'['MapTypeId']['ROADMAP']
                });]);*/
        //var globe = new Globe(this._container);
        this._globe = new JsObject(context['DAT']['Globe'], [container]);
        print(this._globe);

        /*
        this._globe = new JsObject(this._globeConstructor, [this._container]);
        window.console.log(this._globe);

         */

        this._tween = context['TWEEN'];
    }

    void start() {
        this._tween.callMethod('start');
    }

    void addData(List<num> _data, Map<String, String> _opts) {

        var data = new JsObject.jsify(_data);
        var opts = new JsObject.jsify(_opts);
        this._globe.callMethod('addData', [data, opts]);

        //new TWEEN.Tween(globe).to({time: t/years.length},500).easing(TWEEN.Easing.Cubic.EaseOut).start();
        /*
        Map<String, int> toArgs = {'time': 1};
        var t = new JsFunction.withThis((_this, args) => context['TWEEN']);
        window.console.log(t);
        var tween = this._tween.callMethod('Tween', [this._globe]);
        print("Tween:");
        print(tween);
        var to = tween.callMethod('to', [toArgs, 500]);
        print("To:");
        print(to);
        var easing = to.callMethod('easing', context['TWEEN']['Easing']['Cubic']['EaseOut']);
        print("Easing:");
        print(easing);
        easing.callMethod('start');
        */
    }

    void createPoints() {
        this._globe.callMethod('createPoints');
    }

    void animate() {
        this._globe.callMethod('animate');
    }

}