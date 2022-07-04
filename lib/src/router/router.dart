import 'dart:ffi';

import 'package:heimdall/heimdall.dart';

class Router {
  final Map<String, RequestHandler> _routeMaps = {};
  final Map<String, Router> _routerMaps = {};

  appendRouter(String path, Router router) {
    _routerMaps[path] = router;
  }

  get(String path, RequestHandler handler) {
    _routeMaps[path] = handler;
  }

  RequestHandler? getHandler(String path) {
    return _routeMaps[path];
  }
}
