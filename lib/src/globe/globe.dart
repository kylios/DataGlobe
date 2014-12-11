part of globe;

class Glabe {

    JsObject _container = new JsObject(context['document']['getElementById'], ['globe_container']);
    JsObject _globe = null;

    Globe() {
        this._globe = new JsObject(context['DAT']['Globe'], [this._container]);
    }


}