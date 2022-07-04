import 'dart:io';

import 'package:heimdall/src/http/http.dart';
import 'package:heimdall/src/context.dart';
import 'package:heimdall/src/router/router.dart';
import 'package:heimdall/src/util/handler.dart';
import 'package:heimdall/src/util/router.dart';

class Heimdall {
  HttpServer? _server;

  final Map<String, RequestHandler> _handlerMap = {};

  final Map<String, Router> _routerMap = {};

  useRouter(String path, Router router) {
    _routerMap[path] = router;
  }

  listen(int port) async {
    _server = await createHtpServer(port);
    _server?.listen((event) {
      var selectedHandler = getHandlerForPath(event.uri.path, _handlerMap);

      if (selectedHandler != null) {
        selectedHandler(event);
      } else {
        var paths = event.uri.path.split("/");
        print(paths);
        paths = paths.sublist(1);

        var selectedRouter = getRouterForPath(paths[0], _routerMap);

        if (selectedRouter != null) {
          selectedRouter.handle(paths, event);
        } else {
          print("Handler not foundaaa");
        }
      }
    });
  }
}

typedef RequestHandler = void Function(Context ctx);
