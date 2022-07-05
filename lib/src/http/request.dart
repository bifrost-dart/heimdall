import 'dart:io';

class Request {
  late String url;
  late String host;
  late HttpHeaders headers;
  late String? body;

  Request(HttpRequest r) {
    url = r.uri.path;

    if (r.connectionInfo != null) {
      host = r.connectionInfo!.remoteAddress.host;
    } else {
      host = "";
    }

    headers = r.headers;
  }
}
