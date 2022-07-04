import "dart:io";

void createHtpServer(int port) async {
  var server = await HttpServer.bind("localhost", port);
  server.listen((req) {});
}
