import 'package:heimdall/heimdall.dart';

RequestHandler? getHandlerForPath(
    String path, Map<String, RequestHandler> handlersMap) {
  return handlersMap[path];
}
