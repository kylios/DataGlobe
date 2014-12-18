#!/usr/bin/env dart

import 'package:dataglobe/server.dart';

void main(List<String> args) {
    Server server = new Server(8081);
    server.start();
}
