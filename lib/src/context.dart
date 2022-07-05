import 'dart:io';

import 'package:heimdall/src/http/request.dart';
import 'package:heimdall/src/http/response.dart';

class Context {
  late Request req;
  late Response res;

  Context(HttpRequest r) {
    req = Request(r);
    res = Response(r);
  }
}
