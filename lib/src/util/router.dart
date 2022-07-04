import 'package:heimdall/heimdall.dart';
import 'package:heimdall/src/router/router.dart';

Router? getRouterForPath(String path, Map<String, Router> routerMap) {
  return routerMap[path];
}
