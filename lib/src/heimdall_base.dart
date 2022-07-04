import 'dart:io';

import 'package:heimdall/src/http/http.dart';
import 'package:heimdall/src/context.dart';
import 'package:heimdall/src/router/router.dart';

class Heimdall {
  HttpServer? _server;

  final List<RequestHandler> _handlers = [];

  final Map<String, Router> _routerMaps = {};

  use(RequestHandler handler) {
    _handlers.add(handler);
  }

  useRouter(String path, Router router) {
    _routerMaps[path] = router;
  }

  listen(int port) async {
    _server = await createHtpServer(port);
    _server?.listen((event) {
      var paths = event.uri.path.split("/");

      var ch = _routerMaps[paths[1]] != null ? _routerMaps[paths[1]] : null;

      var selectedHandler = ch?.getHandler(paths[2]);

      if (selectedHandler != null) {
        selectedHandler(event);
      }
    });
  }
}

typedef RequestHandler = void Function(Context ctx);
