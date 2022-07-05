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

  bool shouldEnableCors = false;

  enableCors() {
    shouldEnableCors = true;
  }

  _configCors(Context ctx) {
    const corsHeaders = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, POST, DELETE, OPTIONS",
      "Access-Control-Allow-Headers": "*",
    };

    ctx.res.headers(corsHeaders);
  }

  useRouter(String path, Router router) {
    _routerMap[path] = router;
  }

  listen(int port) async {
    _server = await createHtpServer(port);
    _server?.listen((event) {
      Context ctx = Context(event);

      if (shouldEnableCors) _configCors(ctx);

      var selectedHandler = getHandlerForPath(ctx.req.url, _handlerMap);

      if (selectedHandler != null) {
        selectedHandler(ctx);
      } else {
        var paths = ctx.req.url.split("/");
        print(paths);
        paths = paths.sublist(1);

        var selectedRouter = getRouterForPath(paths[0], _routerMap);

        if (selectedRouter != null) {
          selectedRouter.handle(paths, ctx);
        } else {
          print("Handler not foundaaa");
        }
      }
    });
  }
}

typedef RequestHandler = void Function(Context ctx);
