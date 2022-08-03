import 'dart:io';

import 'package:heimdall/src/http/http.dart';
import 'package:heimdall/src/context.dart';
import 'package:heimdall/src/middlewares/middleware.dart';
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

  use(RequestHandler h) {
    useMiddleware(h);
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
          print("Handler not found");
        }
      }
    });
  }
}

typedef RequestHandler = void Function(Context ctx);

typedef NextFunction = void Function(Context ctx);

void useMiddleware(dynamic fn) {
  var offset = 0;
  var path = "/";

  if (fn is! Function) {
    var arg = fn;

    // drilling to last value of arg
    while (arg is List<dynamic> && arg.isNotEmpty) {
      arg = arg[0];
    }

    if (fn is! Function) {
      offset = 1;
      path = fn;
    }
  }
}
