import 'dart:html';
//import 'dart:js';

//import 'package:dataglobe/globe.dart' show Globe;
import 'package:dataglobe/globe.dart';

void main() {

  window.console.log('starting');

  /*
  var container = querySelector('#globe_container');
  //var container = context['document'].callMethod('getElementById', ['globe_container']);

  var globe = new JsObject(context['DAT']['Globe'], [container]);
  window.console.log(globe);
  globe.callMethod('addData', [[120, 60, 100], 'magnitude', 'test']);
  globe.callMethod('createPoints');
  globe.callMethod('animate');
    */

  Globe globe = new Globe();


  print('done');
}
