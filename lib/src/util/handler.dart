import 'package:heimdall/core.dart';

RequestHandler? getHandlerForPath(
    String path, Map<String, RequestHandler> handlersMap) {
  return handlersMap[path];
}
