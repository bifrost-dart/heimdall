import 'package:heimdall/src/http/http.dart';

class Heimdall {
  use(String handler) {}

  listen(int port) {
    createHtpServer(port);
  }
}
