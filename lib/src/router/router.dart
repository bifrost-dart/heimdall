import 'package:heimdall/core.dart';
import 'package:heimdall/src/context.dart';
import 'package:heimdall/src/util/path.dart';
import 'package:heimdall/src/util/router.dart';

class Router {
  final Map<String, RequestHandler> _handlerMap = {};
  final Map<String, Router> _routerMap = {};

  appendRouter(String path, Router router) {
    _routerMap[path] = router;
  }

  get(String path, RequestHandler handler) {
    _handlerMap[path] = handler;
  }

  RequestHandler? _getHandler(List<String> paths) {
    return _handlerMap[paths[0]];
  }

  handle(List<String> paths, Context ctx) {
    var remainingPaths = getRemainingPath(paths);

    if (remainingPaths != null) {
      var selectedHandler = _getHandler(remainingPaths);

      if (selectedHandler != null) {
        selectedHandler(ctx);
      } else {
        var selectedRouter = getRouterForPath(remainingPaths[0], _routerMap);

        if (selectedRouter != null) {
          selectedRouter.handle(remainingPaths, ctx);
        }
      }
    } else {
      var selectedHandler = _handlerMap["/"];

      if (selectedHandler != null) {
        selectedHandler(ctx);
      } else {
        print("Handler not dound");
      }
    }
  }
}
