import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

class Request {
  late String methode;
  late String url;
  late String host;
  late HttpHeaders headers;
  late String? body;

  late HttpRequest _req;

  late Future<Uint8List> first;

  Request(HttpRequest r) {
    methode = r.method;

    url = r.uri.path;

    if (r.connectionInfo != null) {
      host = r.connectionInfo!.remoteAddress.host;
    } else {
      host = "";
    }

    first = r.first;
  }

  transform<S>(StreamTransformer<Uint8List, S> streamTransformer) {
    return _req.transform<S>(streamTransformer);
  }
}
