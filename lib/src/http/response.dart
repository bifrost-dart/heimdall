import 'dart:io';

class Response {
  late HttpRequest _req;

  Response(HttpRequest r) {
    _req = r;
  }

  status(int code) {
    _req.response.statusCode = code;
  }

  headers(Map<String, String> headerMap) {
    headerMap.forEach((k, v) {
      _req.response.headers.add(k, v);
    });
  }

  send(Object obj) {
    _req.response.write(obj);
    _req.response.close();
  }

  close() {
    _req.response.close();
  }
}
